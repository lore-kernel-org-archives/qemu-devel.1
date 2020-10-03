Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD16C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 11:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB4B206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 11:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB4B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOg1i-0006kv-C4
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 07:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOg0m-0006Ec-F9
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 07:47:40 -0400
Received: from mail-oln040092004040.outbound.protection.outlook.com
 ([40.92.4.40]:41703 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOg0g-0005rz-KM
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 07:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsyr8Vv2JbKvKP3JfYyk5F5S4EIfQkPg23dYUMvLyWO4u1ICFJzvy25CsHkzrfHVKidZHIpREkNtB3U4xGZGcEhFhXdWL+076XSw30fonvb/v3PQpyyY9zkqgQ3GrGutG3Zb8n9dkYliSNVKoW8xXS3mRugfS3G9syZrsTE47I5tZpZPa/mZrXjBLnWmwcfxUnEkCJk+MEtPyQavkClBsyx6DqlzCxOA1Ey+0RFZx5f0fwksL3lXuNC6V/UFHOCGZ41ojUtL/G8/GTHL8e/dXDP5vPmP+W+XjfkGdTpNnlv3HgXVswjQ9arjFDivUjWC6p4EzlfJHL6ujswr61wDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrYWebvyPaBu6dkh7v5mnu8Ly71A9rbRvwRfGYowVpM=;
 b=naplWkuRZiv4+VDugVX+BpwfKoqJDi84jqepH6qVvF+RiJmFHYvtguWsl/xwX/QPKk8cfOyDAJPVDJdCx3obImgY22jJdUc4syuVoL8N2DWKeZ6Qud6O3gQV/9YhMLSC8PLK2k3z0ntDnHg5YDFfO3VRVjX6MwPp7BpyqQVNcz8dLcbnOSaLHGmbaYS8Kl+FHFl1mZBxqbPAYqnLYoZMsNaqFDBSGNpwcq0yx7itMJomW+Ka8fYY2+YOwPzJXKwLBgUfPmuQUMPWy+T+IQrZFpLYtsFC4rwespiwT/Ui/cATOxakxkchMd0Tqt+hwPPFF5nqu8Z85p+ZpAhuDU8YzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrYWebvyPaBu6dkh7v5mnu8Ly71A9rbRvwRfGYowVpM=;
 b=fUt3uKHJQ5fccQg0GJrWdXnoZjKUOvnJnCW9KKWQfVxuc1i5R79It9mLwFtK2rlyDu8dTKgnCERXqWkJEuJqEkv8tmOogr0LPMZi5RjODl6ogJ2q35O6cBGZdFyjHM/4slDQLNBZIkxVmyxb46dE71WBRhYNMjI1gg7xeV7QR0hI3KvKPBOpeULEtFpS42er0Q8vN8nYM4ffoP8BKc+Ut5n4scAnH9wIN5ASpVOu7mPyYCGhCdHbMQsJNhaUrNHEOCaBTedtlR8DezI0EOCPT9t9hqWksAsSL55+R4ztKZkcNyicGxC0C0lUfQTTpcx2EM+oIR7ZUD/u7Qok5kHLhg==
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (10.152.76.60) by BL2NAM02HT081.eop-nam02.prod.protection.outlook.com
 (10.152.77.223) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Sat, 3 Oct
 2020 11:47:28 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:7e46::42) by BL2NAM02FT041.mail.protection.outlook.com
 (2a01:111:e400:7e46::378) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39 via Frontend
 Transport; Sat, 3 Oct 2020 11:47:28 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Sat, 3 Oct 2020
 11:47:28 +0000
From: Hee-cheol Yang <heecheol.yang@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v3] hw/avr: Add limited support for avr gpio registers
Thread-Topic: [PATCH v3] hw/avr: Add limited support for avr gpio registers
Thread-Index: AQHWmXr4UorwIfq7z029DSpik/NwLw==
Date: Sat, 3 Oct 2020 11:47:28 +0000
Message-ID: <DM6PR16MB2473974517176215E9519911E60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
References: <DM6PR16MB2473011E7C5B4625CD2E85A1E60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
In-Reply-To: <DM6PR16MB2473011E7C5B4625CD2E85A1E60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:08C6F9E6FEF6628EF3E85F7A8C5802AB63610BC87CB2920EA91B84C8D5CA3F05;
 UpperCasedChecksum:208A183DC4AF571D43E603D28D92B8F5F4ADA840917DB182269861E447E8ED9D;
 SizeAsReceived:9063; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [uHJunLeAz2Ne5M/vKyxJnFpdIZbRglAY]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 0068426c-e318-46ba-4717-08d867921a9d
x-ms-exchange-slblob-mailprops: =?ks_c_5601-1987?B?QWF5WmRpTzRaYkxpbHg1Tjk4SGNSbFZsSndoUW5xSHJ2bUNPTmFW?=
 =?ks_c_5601-1987?B?NEFHVXdNSEl5SElvVHhYaWg0RjhwVnNoWlQ4alFVcTNQMldaTHhU?=
 =?ks_c_5601-1987?B?T2k3Yzl4SUFTaGxGRVRqNk0rWHBzSWwxNFI5Z0U2VVljanNRSHp4?=
 =?ks_c_5601-1987?B?UW00YzUyaERNNjNiWDFBSFhFcDMxNjRRZ1F3VUlvUExlUE9jdGVV?=
 =?ks_c_5601-1987?B?bk9zenlzd3Y0aGpLSmVBeTN2dTRyYUo4am45UFlOalM5L2p1eDVP?=
 =?ks_c_5601-1987?B?VkFSOHBVbVNoRkpNU0FQTjV0ZkJhNFJHQndvTUo2OVBFdUw5dEFs?=
 =?ks_c_5601-1987?B?dFplSGcwcWFzZzJsTkZLWDRzdVYvcnBXN1VlLzJmajRkTEtWZlB0?=
 =?ks_c_5601-1987?B?RGtPN054cTEvdWs1OGE1TzYvS1c1bkh5QVVtWlhqVHFRODduRUxk?=
 =?ks_c_5601-1987?B?ekVmeFFsY3h1Unl6aExqVngvREI5bkd3diszd3ZiRHRFQTJBMFV2?=
 =?ks_c_5601-1987?B?WTViQ1FLYzk2clpiMnpXUEIzaGJFNjd2U3JWcWZHQzBRbVhUZE5Q?=
 =?ks_c_5601-1987?B?Nlh6L0ZsMnFqaisxeSsvV1RkT045ZTR2V0V1UmY1Q0NKT2JpZWMz?=
 =?ks_c_5601-1987?B?andjbVFCczIxUTUxOXptUWxLZzFzTUJKS1kzd2VxMjk4TGdRUzZN?=
 =?ks_c_5601-1987?B?cllGV3F4WWRKaVhtWitnbTZ0Rm9jL2l6d3NEQ2FWYVQwVkgyRXI1?=
 =?ks_c_5601-1987?B?VTVDRTRQVHM5SWEyM01OMnhxODRYRC9iOWJaQnRMU0QzcnFxRzRT?=
 =?ks_c_5601-1987?B?SWhwUi9keXc0TXZaWHVXZ1ZXQlVhQm5SYk9TeGVpektjTjNPMUxr?=
 =?ks_c_5601-1987?B?V3Nyb3Y4NGNaZzdDeUVHd2F6YnlNcFFNeHpOVTJISGVJbEJTRkRq?=
 =?ks_c_5601-1987?B?U3J2c3dMS2I4SmtEOTdWSkVRYk8wcEw0aEtVNE45dTR3TU85U3Jq?=
 =?ks_c_5601-1987?B?YUZEcy9uRVN6dmJvRDJmdlNuQ2s5aHpDNjFIZnZvVzF3cHN0ZmFx?=
 =?ks_c_5601-1987?B?eHhEOWRQY3J2akYyMlBiSGZzYU5ibUlqYUpnRWVDZTRSbzlGNUdU?=
 =?ks_c_5601-1987?B?aGY0cndEREVJVkRscjAzUEVGMnNFdXljRnVmZGcvRmdlM29IdDNY?=
 =?ks_c_5601-1987?B?WmR4K09QbDR5N1JldWVKWExQZjdHdG5rTHk5dDdncHJYbWcwZ09i?=
 =?ks_c_5601-1987?B?blM1WUdCbHM5YmNPY0p2eWZ3R0gzeUZ4NFNtUmp0RXBQWUJsbnhm?=
 =?ks_c_5601-1987?B?SWdXbU02VGNSTGlHOEwvUFV0WEVCcytYVUphS1ppNHBvY3R0Z2ls?=
 =?ks_c_5601-1987?B?bTYreXE2QnJhWGVUU3daZktDSzBad2YrelMrZXlOdXAyUWN4M3FV?=
 =?ks_c_5601-1987?B?ZENIYlhrTU5NMHkxQ1hQTSs5TlV6NVVhakRkdC9kMW9lb3VodTNv?=
 =?ks_c_5601-1987?B?R0VueHBocUFHS3E2S3hDWVZvYmtJSkpVTFBCNWdpNlRrZ1ZzZG5B?=
 =?ks_c_5601-1987?B?PT0=?=
x-ms-traffictypediagnostic: BL2NAM02HT081:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoKFwSin8/9EjQIcW4QbB+DFJBh+OZzEzWUUOvbTlWy1t4ltyiYCh2wbnZ0NjNmMiA2jD2v6X21oNFunjePBt9iPgJQ9DtnwO/UmBnFiSW5GDunoYNilvY6Y/7G+s8A1QRiBm2KnhImjXcZA5P0a0UAuhQHslTHiRE1mmL0PSXsa3P8ZoXtarFyCNqK8UEVY44HW5kg6sKp92OjCVqXVIGBAq+/2pZDbQEXOyejmegbCoShohWLQUQfbYLWPdRgh
x-ms-exchange-antispam-messagedata: ALxIKiQ659FVhDNcj3EswQXnPMPEJmZedn2ZRzfSgxcqsykB14VV3CenIJeX4fORTd2++x8/xTM/eL+0/XN4EB6yHTnQTAQEVNocdeeNP7sxl3BfW/FBJS3oxJdDZ4jfKGNCzIIFcEMzt4oa8y5hog==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR16MB2473974517176215E9519911E60E0DM6PR16MB2473namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0068426c-e318-46ba-4717-08d867921a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 11:47:28.2036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT081
Received-SPF: pass client-ip=40.92.4.40;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 07:47:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "S.E.Harris@kent.ac.uk" <S.E.Harris@kent.ac.uk>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>,
 Hee-cheol Yang <heecheol.yang@outlook.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR16MB2473974517176215E9519911E60E0DM6PR16MB2473namp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SSBhbSB2ZXJ5IHNvcnJ5IGZvciB5b3VyIGluY29udmVuaWVuY2UuIFRoaXMgaXMgM3JkIHZlcnNp
b24gb2YgdGhlIHBhdGNoIGZvciB3aGF0IEkgZGlkLg0KSSBzaG91bGQgaGF2ZSByZWFkIHRoZSBj
b250cmlidXRpb24gZ3VpZGUgYWdhaW4gYW5kIGFnYWluLiBJIGFtIHZlcnkgc29ycnkgYWdhaW4u
DQoNClRoZSBjb250ZW50cyBvZiB0aGUgcGF0Y2ggaXMgdGhlIHNhbWUgd2l0aCB0aGUgdjIuIFRo
aXMgbWFpbCBpcyBqdXN0IGZvciBwYXRjaGV3IGFuZCBtYWtpbmcgYSBuZXcgdGhyZWFkLg0KSGVy
ZSBhcmUgd2hhdCBJIGNoYW5nZWQgZnJvbSB0aGUgdjE6DQoNCiAgKiAgIFJlbW92ZSB1bm5lY2Vz
c2FyeSBoZWFkZXIgaW5jbHVzaW9ucw0KICAqICAgUmVwbGFjZSBjb2RlcyBmb3IgdW5yZWFjaGFi
bGUgY29uZGl0aW9ucyB3aXRoIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkgZnVuY3Rpb24NCiAgKiAg
IFJlbW92ZSAnZW5hYmxlJyBmaWVsZCBmcm9tIEFWUkdQSU9TdGF0ZSBzdHJ1Y3R1cmU6IEl0IGlz
IGFjdHVhbGx5IHVubmVjZXNzYXJ5LiBJIGNvcGllZCB0aGlzIGZpZWxkIGZyb20gQVZSVVNBUlRT
dGF0ZSBzdHJ1Y3R1cmUuDQoNClRoYW5rcyBhIGxvdCENCldpdGggYmVzdCByZWdhcmRzDQpIZWVj
aGVvbCBZYW5nLg0KDQpBZGQgc29tZSBvZiB0aGVzZSBmZWF0dXJlcyBmb3IgYXZyIGdwaW86DQoN
CiAgLSBHUElPIEkvTyA6IFBPUlR4IHJlZ2lzdGVycw0KICAtIERhdGEgRGlyZWN0aW9uIDogRERS
eCByZWdpc3RlcnMNCg0KRm9sbG93aW5nIHRoaW5ncyBhcmUgbm90IHN1cHBvcnRlZCB5ZXQ6DQog
IC0gUElOeCByZWdpc3RlcnMNCiAgLSBNQ1VSIHJlZ2lzdGVycw0KICAtIEV2ZW4gdGhvdWdoIHJl
YWQvd3JpdGUgZm9yIEREUnggcmVnaXN0ZXJzIGFyZQ0KICAgIGltcGxlbWVudGVkLCBhY3R1YWwg
ZGlyZWN0aW9uIGNvbnRyb2xzIGFyZSBub3QNCiAgICBzdXBwb3J0ZWQgeWV0Lg0KDQpTaWduZWQt
b2ZmLWJ5OiBIZWVjaGVvbCBZYW5nIDxoZWVjaGVvbC55YW5nQG91dGxvb2suY29tPg0KLS0tDQog
aHcvYXZyL0tjb25maWcgICAgICAgICAgICAgfCAgIDEgKw0KIGh3L2F2ci9hdG1lZ2EuYyAgICAg
ICAgICAgIHwgICA3ICsrLQ0KIGh3L2F2ci9hdG1lZ2EuaCAgICAgICAgICAgIHwgICAyICsNCiBo
dy9ncGlvL0tjb25maWcgICAgICAgICAgICB8ICAgMyArDQogaHcvZ3Bpby9hdnJfZ3Bpby5jICAg
ICAgICAgfCAxMTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGh3L2dw
aW8vbWVzb24uYnVpbGQgICAgICAgIHwgICAyICsNCiBpbmNsdWRlL2h3L2dwaW8vYXZyX2dwaW8u
aCB8ICA0NiArKysrKysrKysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDE3MSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9ncGlvL2F2cl9ncGlv
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9ncGlvL2F2cl9ncGlvLmgNCg0KZGlm
ZiAtLWdpdCBhL2h3L2F2ci9LY29uZmlnIGIvaHcvYXZyL0tjb25maWcNCmluZGV4IGQzMTI5OGMz
Y2MuLjE2YTU3Y2VkMTEgMTAwNjQ0DQotLS0gYS9ody9hdnIvS2NvbmZpZw0KKysrIGIvaHcvYXZy
L0tjb25maWcNCkBAIC0zLDYgKzMsNyBAQCBjb25maWcgQVZSX0FUTUVHQV9NQ1UNCiAgICAgc2Vs
ZWN0IEFWUl9USU1FUjE2DQogICAgIHNlbGVjdCBBVlJfVVNBUlQNCiAgICAgc2VsZWN0IEFWUl9Q
T1dFUg0KKyAgICBzZWxlY3QgQVZSX0dQSU8NCg0KIGNvbmZpZyBBUkRVSU5PDQogICAgIHNlbGVj
dCBBVlJfQVRNRUdBX01DVQ0KZGlmZiAtLWdpdCBhL2h3L2F2ci9hdG1lZ2EuYyBiL2h3L2F2ci9h
dG1lZ2EuYw0KaW5kZXggNDRjNmFmZWJiYi4uYWQ5NDIwMjhmZCAxMDA2NDQNCi0tLSBhL2h3L2F2
ci9hdG1lZ2EuYw0KKysrIGIvaHcvYXZyL2F0bWVnYS5jDQpAQCAtMjgzLDggKzI4MywxMSBAQCBz
dGF0aWMgdm9pZCBhdG1lZ2FfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
DQogICAgICAgICAgICAgY29udGludWU7DQogICAgICAgICB9DQogICAgICAgICBkZXZuYW1lID0g
Z19zdHJkdXBfcHJpbnRmKCJhdG1lZ2EtZ3Bpby0lYyIsICdhJyArIChjaGFyKWkpOw0KLSAgICAg
ICAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKGRldm5hbWUsDQotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgT0ZGU0VUX0RBVEEgKyBtYy0+ZGV2W2lkeF0uYWRkciwgMyk7
DQorICAgICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QoZGV2KSwgZGV2bmFtZSwg
JnMtPmdwaW9baV0sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0FWUl9H
UElPKTsNCisgICAgICAgIHN5c2J1c19yZWFsaXplKFNZU19CVVNfREVWSUNFKCZzLT5ncGlvW2ld
KSwgJmVycm9yX2Fib3J0KTsNCisgICAgICAgIHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklD
RSgmcy0+Z3Bpb1tpXSksIDAsDQorICAgICAgICAgICAgT0ZGU0VUX0RBVEEgKyBtYy0+ZGV2W2lk
eF0uYWRkcik7DQogICAgICAgICBnX2ZyZWUoZGV2bmFtZSk7DQogICAgIH0NCg0KZGlmZiAtLWdp
dCBhL2h3L2F2ci9hdG1lZ2EuaCBiL2h3L2F2ci9hdG1lZ2EuaA0KaW5kZXggYTk5ZWUxNWM3ZS4u
ZTIyODlkNTc0NCAxMDA2NDQNCi0tLSBhL2h3L2F2ci9hdG1lZ2EuaA0KKysrIGIvaHcvYXZyL2F0
bWVnYS5oDQpAQCAtMTMsNiArMTMsNyBAQA0KDQogI2luY2x1ZGUgImh3L2NoYXIvYXZyX3VzYXJ0
LmgiDQogI2luY2x1ZGUgImh3L3RpbWVyL2F2cl90aW1lcjE2LmgiDQorI2luY2x1ZGUgImh3L2dw
aW8vYXZyX2dwaW8uaCINCiAjaW5jbHVkZSAiaHcvbWlzYy9hdnJfcG93ZXIuaCINCiAjaW5jbHVk
ZSAidGFyZ2V0L2F2ci9jcHUuaCINCiAjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KQEAgLTQ0LDYg
KzQ1LDcgQEAgc3RydWN0IEF0bWVnYU1jdVN0YXRlIHsNCiAgICAgRGV2aWNlU3RhdGUgKmlvOw0K
ICAgICBBVlJNYXNrU3RhdGUgcHdyW1BPV0VSX01BWF07DQogICAgIEFWUlVzYXJ0U3RhdGUgdXNh
cnRbVVNBUlRfTUFYXTsNCisgICAgQVZSR1BJT1N0YXRlIGdwaW9bR1BJT19NQVhdOw0KICAgICBB
VlJUaW1lcjE2U3RhdGUgdGltZXJbVElNRVJfTUFYXTsNCiAgICAgdWludDY0X3QgeHRhbF9mcmVx
X2h6Ow0KIH07DQpkaWZmIC0tZ2l0IGEvaHcvZ3Bpby9LY29uZmlnIGIvaHcvZ3Bpby9LY29uZmln
DQppbmRleCBiNmZkYWEyNTg2Li4xNzUyZDBjZTU2IDEwMDY0NA0KLS0tIGEvaHcvZ3Bpby9LY29u
ZmlnDQorKysgYi9ody9ncGlvL0tjb25maWcNCkBAIC0xMCwzICsxMCw2IEBAIGNvbmZpZyBHUElP
X0tFWQ0KDQogY29uZmlnIFNJRklWRV9HUElPDQogICAgIGJvb2wNCisNCitjb25maWcgQVZSX0dQ
SU8NCisgICAgYm9vbA0KZGlmZiAtLWdpdCBhL2h3L2dwaW8vYXZyX2dwaW8uYyBiL2h3L2dwaW8v
YXZyX2dwaW8uYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAuLjZjYThl
ODcwM2ENCi0tLSAvZGV2L251bGwNCisrKyBiL2h3L2dwaW8vYXZyX2dwaW8uYw0KQEAgLTAsMCAr
MSwxMTIgQEANCisvKg0KKyAqIEFWUiBwcm9jZXNzb3JzIEdQSU8gcmVnaXN0ZXJzIGVtdWxhdGlv
bi4NCisgKg0KKyAqIENvcHlyaWdodCAoQykgMjAyMCBIZWVjaGVvbCBZYW5nIDxoZWVjaGVvbC55
YW5nQG91dGxvb2suY29tPg0KKyAqDQorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcg0KKyAqIG1vZGlmeSBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzDQorICogcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb3INCisg
KiAoYXQgeW91ciBvcHRpb24pIHZlcnNpb24gMyBvZiB0aGUgTGljZW5zZS4NCisgKg0KKyAqIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLA0KKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mDQorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGZvciBtb3JlIGRldGFpbHMuDQorICoNCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZw0KKyAqIHdpdGggdGhp
cyBwcm9ncmFtOyBpZiBub3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQor
ICovDQorI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCisjaW5jbHVkZSAicWVtdS9sb2cuaCINCisj
aW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCisjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KKyNpbmNs
dWRlICJody9zeXNidXMuaCINCisjaW5jbHVkZSAiaHcvaXJxLmgiDQorI2luY2x1ZGUgImh3L2dw
aW8vYXZyX2dwaW8uaCINCisjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQorDQorc3Rh
dGljIHZvaWQgYXZyX2dwaW9fcmVzZXQoRGV2aWNlU3RhdGUgKmRldikNCit7DQorICAgIEFWUkdQ
SU9TdGF0ZSAqZ3BpbyA9IEFWUl9HUElPKGRldik7DQorICAgIGdwaW8tPmRkcl92YWwgPSAwdTsN
CisgICAgZ3Bpby0+cG9ydF92YWwgPSAwdTsNCit9DQorc3RhdGljIHVpbnQ2NF90IGF2cl9ncGlv
X3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LCB1bnNpZ25lZCBpbnQgc2l6ZSkNCit7
DQorICAgIEFWUkdQSU9TdGF0ZSAqcyA9IChBVlJHUElPU3RhdGUgKilvcGFxdWU7DQorICAgIHN3
aXRjaCAob2Zmc2V0KSB7DQorICAgIGNhc2UgR1BJT19QSU46DQorICAgICAgICAvKiBOb3QgaW1w
bGVtZW50ZWQgeWV0ICovDQorICAgICAgICBicmVhazsNCisgICAgY2FzZSBHUElPX0REUjoNCisg
ICAgICAgIHJldHVybiBzLT5kZHJfdmFsOw0KKyAgICAgICAgYnJlYWs7DQorICAgIGNhc2UgR1BJ
T19QT1JUOg0KKyAgICAgICAgcmV0dXJuIHMtPnBvcnRfdmFsOw0KKyAgICBkZWZhdWx0Og0KKyAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCisgICAgICAgIGJyZWFrOw0KKyAgICB9DQor
ICAgIHJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCBhdnJfZ3Bpb193cml0ZSh2b2lkICpv
cGFxdWUsIGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHNpemUpDQorew0KKyAgICBBVlJHUElPU3RhdGUg
KnMgPSAoQVZSR1BJT1N0YXRlICopb3BhcXVlOw0KKyAgICBzd2l0Y2ggKG9mZnNldCkgew0KKyAg
ICBjYXNlIEdQSU9fUElOOg0KKyAgICAgICAgLyogTm90IGltcGxlbWVudGVkIHlldCAqLw0KKyAg
ICAgICAgYnJlYWs7DQorICAgIGNhc2UgR1BJT19ERFI6DQorICAgICAgICBzLT5kZHJfdmFsID0g
dmFsdWUgJiAweEY7DQorICAgICAgICBicmVhazsNCisgICAgY2FzZSBHUElPX1BPUlQ6DQorICAg
ICAgICBzLT5wb3J0X3ZhbCA9IHZhbHVlICYgMHhGOw0KKyAgICAgICAgYnJlYWs7DQorICAgIGRl
ZmF1bHQ6DQorICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KKyAgICAgICAgYnJlYWs7
DQorICAgIH0NCit9DQorDQorc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBhdnJfZ3Bpb19v
cHMgPSB7DQorICAgIC5yZWFkID0gYXZyX2dwaW9fcmVhZCwNCisgICAgLndyaXRlID0gYXZyX2dw
aW9fd3JpdGUsDQorICAgIC5lbmRpYW5uZXNzID0gREVWSUNFX05BVElWRV9FTkRJQU4sDQorfTsN
CisNCitzdGF0aWMgdm9pZCBhdnJfZ3Bpb19pbml0KE9iamVjdCAqb2JqKQ0KK3sNCisgICAgQVZS
R1BJT1N0YXRlICpzID0gQVZSX0dQSU8ob2JqKTsNCisgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lv
KCZzLT5tbWlvLCBvYmosICZhdnJfZ3Bpb19vcHMsIHMsIFRZUEVfQVZSX0dQSU8sIDMpOw0KKyAg
ICBzeXNidXNfaW5pdF9tbWlvKFNZU19CVVNfREVWSUNFKG9iaiksICZzLT5tbWlvKTsNCit9DQor
c3RhdGljIHZvaWQgYXZyX2dwaW9fcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVy
cnApDQorew0KKyAgICBhdnJfZ3Bpb19yZXNldChkZXYpOw0KK30NCisNCisNCitzdGF0aWMgdm9p
ZCBhdnJfZ3Bpb19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCit7
DQorICAgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQorDQorICAgIGRj
LT5yZXNldCA9IGF2cl9ncGlvX3Jlc2V0Ow0KKyAgICBkYy0+cmVhbGl6ZSA9IGF2cl9ncGlvX3Jl
YWxpemU7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhdnJfZ3Bpb19pbmZvID0gew0K
KyAgICAubmFtZSAgICAgICAgICA9IFRZUEVfQVZSX0dQSU8sDQorICAgIC5wYXJlbnQgICAgICAg
ID0gVFlQRV9TWVNfQlVTX0RFVklDRSwNCisgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoQVZS
R1BJT1N0YXRlKSwNCisgICAgLmluc3RhbmNlX2luaXQgPSBhdnJfZ3Bpb19pbml0LA0KKyAgICAu
Y2xhc3NfaW5pdCAgICA9IGF2cl9ncGlvX2NsYXNzX2luaXQsDQorfTsNCisNCitzdGF0aWMgdm9p
ZCBhdnJfZ3Bpb19yZWdpc3Rlcl90eXBlcyh2b2lkKQ0KK3sNCisgICAgdHlwZV9yZWdpc3Rlcl9z
dGF0aWMoJmF2cl9ncGlvX2luZm8pOw0KK30NCisNCit0eXBlX2luaXQoYXZyX2dwaW9fcmVnaXN0
ZXJfdHlwZXMpDQpkaWZmIC0tZ2l0IGEvaHcvZ3Bpby9tZXNvbi5idWlsZCBiL2h3L2dwaW8vbWVz
b24uYnVpbGQNCmluZGV4IDg2Y2FlOWEwZjMuLjI1OGJkNWRjZmMgMTAwNjQ0DQotLS0gYS9ody9n
cGlvL21lc29uLmJ1aWxkDQorKysgYi9ody9ncGlvL21lc29uLmJ1aWxkDQpAQCAtMTEsMyArMTEs
NSBAQCBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX09NQVAnLCBpZl90cnVlOiBmaWxlcygn
b21hcF9ncGlvLmMnKSkNCiBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX1JBU1BJJywgaWZf
dHJ1ZTogZmlsZXMoJ2JjbTI4MzVfZ3Bpby5jJykpDQogc29mdG1tdV9zcy5hZGQod2hlbjogJ0NP
TkZJR19BU1BFRURfU09DJywgaWZfdHJ1ZTogZmlsZXMoJ2FzcGVlZF9ncGlvLmMnKSkNCiBzb2Z0
bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX1NJRklWRV9HUElPJywgaWZfdHJ1ZTogZmlsZXMoJ3Np
Zml2ZV9ncGlvLmMnKSkNCisNCitzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX0FWUl9HUElP
JywgaWZfdHJ1ZTogZmlsZXMoJ2F2cl9ncGlvLmMnKSkNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L2dwaW8vYXZyX2dwaW8uaCBiL2luY2x1ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oDQpuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMC4uODRkNzgzZjhmYw0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvaW5jbHVkZS9ody9ncGlvL2F2cl9ncGlvLmgNCkBAIC0wLDAgKzEsNDYgQEANCisvKg0K
KyAqIEFWUiBwcm9jZXNzb3JzIEdQSU8gcmVnaXN0ZXJzIGRlZmluaXRpb24uDQorICoNCisgKiBD
b3B5cmlnaHQgKEMpIDIwMjAgSGVlY2hlb2wgWWFuZyA8aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNv
bT4NCisgKg0KKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3INCisgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcw0KKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9yDQorICogKGF0IHlvdXIgb3B0
aW9uKSB2ZXJzaW9uIDMgb2YgdGhlIExpY2Vuc2UuDQorICoNCisgKiBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCisgKiBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
Zg0KKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUNCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLg0KKyAqDQorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcNCisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KKyAqLw0KKw0KKyNpZm5k
ZWYgQVZSX0dQSU9fSA0KKyNkZWZpbmUgQVZSX0dQSU9fSA0KKw0KKyNpbmNsdWRlICJody9zeXNi
dXMuaCINCisjaW5jbHVkZSAicW9tL29iamVjdC5oIg0KKw0KKy8qIE9mZnNldHMgb2YgcmVnaXN0
ZXJzLiAqLw0KKyNkZWZpbmUgR1BJT19QSU4gICAweDAwDQorI2RlZmluZSBHUElPX0REUiAgIDB4
MDENCisjZGVmaW5lIEdQSU9fUE9SVCAgMHgwMg0KKw0KKyNkZWZpbmUgVFlQRV9BVlJfR1BJTyAi
YXZyLWdwaW8iDQorT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQVZSR1BJT1N0YXRlLCBBVlJf
R1BJTykNCisNCitzdHJ1Y3QgQVZSR1BJT1N0YXRlIHsNCisgICAgLyo8IHByaXZhdGUgPiovDQor
ICAgIFN5c0J1c0RldmljZSBwYXJlbnRfb2JqOw0KKw0KKyAgICAvKjwgcHVibGljID4qLw0KKyAg
ICBNZW1vcnlSZWdpb24gbW1pbzsNCisNCisgICAgdWludDhfdCBkZHJfdmFsOw0KKyAgICB1aW50
OF90IHBvcnRfdmFsOw0KKw0KK307DQorDQorI2VuZGlmIC8qIEFWUl9HUElPX0ggKi8NCi0tDQoy
LjE3LjENCg0K

--_000_DM6PR16MB2473974517176215E9519911E60E0DM6PR16MB2473namp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I am very sorry for your inconvenience. This is 3rd version of the patch fo=
r what I did.&nbsp;</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I should have read the contribution guide again and again. I am very sorry =
again.</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The contents of the patch is the same with the v2. This mail is just for pa=
tchew and making a new thread.</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"font-size: 12pt; font-family: Gulim, =B1=BC=B8=B2, &quot;Nanu=
m Gothic&quot;, sans-serif">
Here are what I changed from the v1:</div>
<div style=3D"font-size: 12pt; font-family: Gulim, =B1=BC=B8=B2, &quot;Nanu=
m Gothic&quot;, sans-serif">
<ul>
<li>Remove unnecessary header inclusions</li><li>Replace codes for unreacha=
ble conditions with g_assert_not_reached() function</li><li>Remove 'enable'=
 field from AVRGPIOState structure: It is actually unnecessary. I copied th=
is field from AVRUSARTState structure.</li></ul>
</div>
<br>
</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks a lot!</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
With best regards</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Heecheol Yang.</div>
<div style=3D"font-family: Gulim, =B1=BC=B8=B2, &quot;Nanum Gothic&quot;, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add some of these features for avr gpio:<br>
<br>
&nbsp; - GPIO I/O : PORTx registers<br>
&nbsp; - Data Direction : DDRx registers<br>
<br>
Following things are not supported yet:<br>
&nbsp; - PINx registers<br>
&nbsp; - MCUR registers<br>
&nbsp; - Even though read/write for DDRx registers are<br>
&nbsp;&nbsp;&nbsp; implemented, actual direction controls are not<br>
&nbsp;&nbsp;&nbsp; supported yet.<br>
<br>
Signed-off-by: Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
---<br>
&nbsp;hw/avr/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;hw/avr/atmega.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 7 ++-<br>
&nbsp;hw/avr/atmega.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/gpio/avr_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
112 +++++++++++++++++++++++++++++++++++++<br>
&nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 2 +<br>
&nbsp;include/hw/gpio/avr_gpio.h |&nbsp; 46 +++++++++++++++<br>
&nbsp;7 files changed, 171 insertions(+), 2 deletions(-)<br>
&nbsp;create mode 100644 hw/gpio/avr_gpio.c<br>
&nbsp;create mode 100644 include/hw/gpio/avr_gpio.h<br>
<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
index d31298c3cc..16a57ced11 100644<br>
--- a/hw/avr/Kconfig<br>
+++ b/hw/avr/Kconfig<br>
@@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_TIMER16<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_USART<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_POWER<br>
+&nbsp;&nbsp;&nbsp; select AVR_GPIO<br>
&nbsp;<br>
&nbsp;config ARDUINO<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_ATMEGA_MCU<br>
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br>
index 44c6afebbb..ad942028fd 100644<br>
--- a/hw/avr/atmega.c<br>
+++ b/hw/avr/atmega.c<br>
@@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **e=
rrp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devname =3D g_strdup_print=
f(&quot;atmega-gpio-%c&quot;, 'a' + (char)i);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_unimplemented_device(dev=
name,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA +=
 mc-&gt;dev[idx].addr, 3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(OBJECT(=
dev), devname, &amp;s-&gt;gpio[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_AVR_GPIO);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_realize(SYS_BUS_DEVICE(&=
amp;s-&gt;gpio[i]), &amp;error_abort);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(=
&amp;s-&gt;gpio[i]), 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_=
DATA + mc-&gt;dev[idx].addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(devname);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br>
index a99ee15c7e..e2289d5744 100644<br>
--- a/hw/avr/atmega.h<br>
+++ b/hw/avr/atmega.h<br>
@@ -13,6 +13,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;hw/char/avr_usart.h&quot;<br>
&nbsp;#include &quot;hw/timer/avr_timer16.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
&nbsp;#include &quot;hw/misc/avr_power.h&quot;<br>
&nbsp;#include &quot;target/avr/cpu.h&quot;<br>
&nbsp;#include &quot;qom/object.h&quot;<br>
@@ -44,6 +45,7 @@ struct AtmegaMcuState {<br>
&nbsp;&nbsp;&nbsp;&nbsp; DeviceState *io;<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRMaskState pwr[POWER_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRUsartState usart[USART_MAX];<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState gpio[GPIO_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRTimer16State timer[TIMER_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t xtal_freq_hz;<br>
&nbsp;};<br>
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig<br>
index b6fdaa2586..1752d0ce56 100644<br>
--- a/hw/gpio/Kconfig<br>
+++ b/hw/gpio/Kconfig<br>
@@ -10,3 +10,6 @@ config GPIO_KEY<br>
&nbsp;<br>
&nbsp;config SIFIVE_GPIO<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
+<br>
+config AVR_GPIO<br>
+&nbsp;&nbsp;&nbsp; bool<br>
diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c<br>
new file mode 100644<br>
index 0000000000..6ca8e8703a<br>
--- /dev/null<br>
+++ b/hw/gpio/avr_gpio.c<br>
@@ -0,0 +1,112 @@<br>
+/*<br>
+ * AVR processors GPIO registers emulation.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/">http://www.gnu.org/licenses/</a>&gt;.<br>
+ */<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+<br>
+static void avr_gpio_reset(DeviceState *dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *gpio =3D AVR_GPIO(dev);<br>
+&nbsp;&nbsp;&nbsp; gpio-&gt;ddr_val =3D 0u;<br>
+&nbsp;&nbsp;&nbsp; gpio-&gt;port_val =3D 0u;<br>
+}<br>
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int si=
ze)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+&nbsp;&nbsp;&nbsp; switch (offset) {<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;ddr_val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;port_val;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert_not_reached();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+&nbsp;&nbsp;&nbsp; switch (offset) {<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ddr_val =3D value &amp; 0=
xF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;port_val =3D value &amp; =
0xF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert_not_reached();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static const MemoryRegionOps avr_gpio_ops =3D {<br>
+&nbsp;&nbsp;&nbsp; .read =3D avr_gpio_read,<br>
+&nbsp;&nbsp;&nbsp; .write =3D avr_gpio_write,<br>
+&nbsp;&nbsp;&nbsp; .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+};<br>
+<br>
+static void avr_gpio_init(Object *obj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D AVR_GPIO(obj);<br>
+&nbsp;&nbsp;&nbsp; memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;avr_gp=
io_ops, s, TYPE_AVR_GPIO, 3);<br>
+&nbsp;&nbsp;&nbsp; sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);=
<br>
+}<br>
+static void avr_gpio_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; avr_gpio_reset(dev);<br>
+}<br>
+<br>
+<br>
+static void avr_gpio_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D avr_gpio_reset;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;realize =3D avr_gpio_realize;<br>
+}<br>
+<br>
+static const TypeInfo avr_gpio_info =3D {<br>
+&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D TYPE_AVR_GPIO,<br>
+&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D T=
YPE_SYS_BUS_DEVICE,<br>
+&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(AVRGPIOState),<br>
+&nbsp;&nbsp;&nbsp; .instance_init =3D avr_gpio_init,<br>
+&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D avr_gpio_class_init,<=
br>
+};<br>
+<br>
+static void avr_gpio_register_types(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; type_register_static(&amp;avr_gpio_info);<br>
+}<br>
+<br>
+type_init(avr_gpio_register_types)<br>
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br>
index 86cae9a0f3..258bd5dcfc 100644<br>
--- a/hw/gpio/meson.build<br>
+++ b/hw/gpio/meson.build<br>
@@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_=
gpio.c'))<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c')=
)<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio=
.c'))<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpi=
o.c'))<br>
+<br>
+softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))<br>
diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h<br>
new file mode 100644<br>
index 0000000000..84d783f8fc<br>
--- /dev/null<br>
+++ b/include/hw/gpio/avr_gpio.h<br>
@@ -0,0 +1,46 @@<br>
+/*<br>
+ * AVR processors GPIO registers definition.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/">http://www.gnu.org/licenses/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef AVR_GPIO_H<br>
+#define AVR_GPIO_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+<br>
+/* Offsets of registers. */<br>
+#define GPIO_PIN&nbsp;&nbsp; 0x00<br>
+#define GPIO_DDR&nbsp;&nbsp; 0x01<br>
+#define GPIO_PORT&nbsp; 0x02<br>
+<br>
+#define TYPE_AVR_GPIO &quot;avr-gpio&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)<br>
+<br>
+struct AVRGPIOState {<br>
+&nbsp;&nbsp;&nbsp; /*&lt; private &gt;*/<br>
+&nbsp;&nbsp;&nbsp; SysBusDevice parent_obj;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*&lt; public &gt;*/<br>
+&nbsp;&nbsp;&nbsp; MemoryRegion mmio;<br>
+<br>
+&nbsp;&nbsp;&nbsp; uint8_t ddr_val;<br>
+&nbsp;&nbsp;&nbsp; uint8_t port_val;<br>
+<br>
+};<br>
+<br>
+#endif /* AVR_GPIO_H */<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR16MB2473974517176215E9519911E60E0DM6PR16MB2473namp_--

