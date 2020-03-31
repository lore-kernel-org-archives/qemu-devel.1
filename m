Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B93EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3089320BED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NkBKgMZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKbX-0001iY-Af
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <namit@vmware.com>) id 1jJJth-0003VN-In
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <namit@vmware.com>) id 1jJJte-00020W-Bu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:37:53 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com
 ([40.107.243.42]:8705 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <namit@vmware.com>) id 1jJJtd-0001zK-8p
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DR2e8Juy8BBFdYYWsQr2LwgLq3p4jg+ipTkHBwK9Dq5p3M2AIkYwK09IO5WbFMjLHyHmvG+t7v8/A47BipiKqEZhxrgqCDhJq3CiX/v00IfS3Kw/ZakQC8Zb7wsgxuhXchwRbshvwPbxeaokwGFJvrfeim3FcoXiD88bjbKlfZClGveSrhCoXXvrfGzcOxdGrBbjZPDR89kbsljv/8iIj1SpI/Mg40WbZ8zPfNbhZrAIz/aEpXT3Bh2KmG60O2zKmhKhovxexd/nH4VqQe71oMl0I22NDFvj57T6W9ei1OQBsvaNOM6GCC+du46NYlQYgs0Qn+aWdOhoRqbKVsl/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6X2klDaI5s2HpqRZCU18HamNh9V1/ZjIhHAckmq4ko=;
 b=dVOgQiQtSr5Y5IaxL0Bx3jvqNWK3k1cj/j7EdWfVWXN6vLkGO/E73neBDRyqnAYSEVn8ERv6gDZhbfHNa6FOwte+y3xkNq3N/qG59KnXjDEOANJZg8BL3P0Z5W30EASv0qAZ2t6iMCiO9mfOxihNJuEdWO2E2cmBD3GeFKu5ezinNOaj3zdHNf07QTIwAFB5Jki5ju/WUavn8AU8lgaIIdR8dHwxEet7Bq/FF04AlMDuqOQMDfUWgMTJEhWoyxsr9bjwSVS8HorL1+oJZ9q0gROHOvfCoDlK+JgE7A9Tj1t0kMjHarbch4oEPfIBzOFcpjP15BfzIzUkhXCMCQIViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6X2klDaI5s2HpqRZCU18HamNh9V1/ZjIhHAckmq4ko=;
 b=NkBKgMZBqaSy1VaPV3JU9/XDSqjrKUyxwEN0qySV3D8jgNgqI5/ZPw5DCE6u048At9iJ0OjP80MZdkwfFA/vQ0iw9JtMdytLhOy/WUuZYEJKw/MPvOQ/vb7oe1ctRn6nCvVGgKbh2NlgRbdkQ6KgacU46FamX+q+3y/pfjdSOVE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4344.namprd05.prod.outlook.com (2603:10b6:a02:f1::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Tue, 31 Mar
 2020 16:37:45 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2878.014; Tue, 31 Mar 2020
 16:37:45 +0000
From: Nadav Amit <namit@vmware.com>
To: David Hildenbrand <david@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "pagupta@redhat.com"
 <pagupta@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mojha@codeaurora.org"
 <mojha@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Linux
 Virtualization <virtualization@lists.linux-foundation.org>, Hui Zhu
 <teawaterz@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Hui Zhu <teawater@gmail.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Thread-Topic: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Thread-Index: AQHV+ELbJxXcLTs5FEiRY3DW9nrWzKhEomsAgAACs4CAAAEugIAV50IAgAAJXACAACBZgIAH6GMAgAAvR4CAAAIWgIAAAXUAgAAHRACAAAELAIAAANOAgAApSAA=
Date: Tue, 31 Mar 2020 16:37:44 +0000
Message-ID: <BABD09DC-217E-4F00-9C05-74ABB4B1E13D@vmware.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
In-Reply-To: <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:4568:145a:b450:27e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97cf9b61-e164-4ee5-045e-08d7d591d705
x-ms-traffictypediagnostic: BYAPR05MB4344:
x-microsoft-antispam-prvs: <BYAPR05MB43446CD9865DCBD697364283D0C80@BYAPR05MB4344.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB4776.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(316002)(7416002)(36756003)(66946007)(6916009)(478600001)(33656002)(71200400001)(6486002)(53546011)(8936002)(86362001)(6512007)(76116006)(66446008)(2616005)(81166006)(2906002)(8676002)(186003)(4326008)(64756008)(5660300002)(81156014)(6506007)(54906003)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvzubaMvqiGynuNlRYNmaIhB2MnGrRjnhTqghBu7fgdEQVa9t21tWJgw9Wkhkl09PWaft6UqsrD7TbGJjrhTpsg4IMRvcpE0oluRvi1oFr7iSB87kdSYCWE/ATq9Hzg0hugfDQSO5xzw2OVujE7yD7+7AbdufK/eGi10wVSDs5EmtY1P+LZm2/Ui3cOJG3Yn+pnRm8jNboZ1YCbwBUZcDAgLJN/rlm+DPBYe5lJXotYnQLSEs7+fYmhFED44JEiGK2SDQG5ls6PXQc7qFHSr67FkxY7wUlBeIBSmbqH/DBxWxUr4Px+NR9wRAUSP+YvJxqZBzW+UxUIfzioxqOCzE+DI04DEHJXFPe3tH3s62kNyyqSFHHDaXgGKL6ncOViB/BOttTVf9fTds++lyD5C+iityZ5SPM8B+61V1wbNQE/qYHoFzlDVmmZgs9mpOB64
x-ms-exchange-antispam-messagedata: OS7Sovxnd7QHddQpGsR/kFqS9W6pniJXKIoHqjY6plmnECNCulfUqtd7DqdhWZDDM4n43oXbGLSlHKBOvY4XIr9aMDlaKXiSdXZ9Lb3AdQxhAcVHQB+9IdW6UmxwcJoRuG/SLTxETvBpc1hwEyhgfqmOzuz1Kpk7c2NaqhC7moDjquHwUeblXP/+D0GH6HasvZQvxrdXNKa4NqbwIDgQOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <21176E85C416AC4BB4C87D98E5352CA3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf9b61-e164-4ee5-045e-08d7d591d705
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:37:44.8909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pysYBZ/Xe7+DO0b+R64eFbTZJOxJTFzEcqCuLk4EF8ScUip8qTVJWIj9yVauwZXI8oMDCwurTZgfIxsM6idTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4344
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.42
X-Mailman-Approved-At: Tue, 31 Mar 2020 13:20:28 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBPbiBNYXIgMzEsIDIwMjAsIGF0IDc6MDkgQU0sIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDMxLjAzLjIwIDE2OjA3LCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6DQo+PiBPbiBUdWUsIE1hciAzMSwgMjAyMCBhdCAwNDowMzoxOFBNICswMjAw
LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+PiBPbiAzMS4wMy4yMCAxNTozNywgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOg0KPj4+PiBPbiBUdWUsIE1hciAzMSwgMjAyMCBhdCAwMzozMjow
NVBNICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4+IE9uIDMxLjAzLjIwIDE1
OjI0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+Pj4+Pj4gT24gVHVlLCBNYXIgMzEsIDIw
MjAgYXQgMTI6MzU6MjRQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4+Pj4+
IE9uIDI2LjAzLjIwIDEwOjQ5LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+Pj4+Pj4+PiBP
biBUaHUsIE1hciAyNiwgMjAyMCBhdCAwODo1NDowNEFNICswMTAwLCBEYXZpZCBIaWxkZW5icmFu
ZCB3cm90ZToNCj4+Pj4+Pj4+Pj4gQW0gMjYuMDMuMjAyMCB1bSAwODoyMSBzY2hyaWViIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Og0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4g
77u/T24gVGh1LCBNYXIgMTIsIDIwMjAgYXQgMDk6NTE6MjVBTSArMDEwMCwgRGF2aWQgSGlsZGVu
YnJhbmQgd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4gT24gMTIuMDMuMjAgMDk6NDcsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToNCj4+Pj4+Pj4+Pj4+PiBPbiBUaHUsIE1hciAxMiwgMjAyMCBhdCAwOToz
NzozMkFNICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4+Pj4+Pj4+Pj4gMi4g
WW91IGFyZSBlc3NlbnRpYWxseSBzdGVhbGluZyBUSFBzIGluIHRoZSBndWVzdC4gU28gdGhlIGZh
c3Rlc3QNCj4+Pj4+Pj4+Pj4+Pj4gbWFwcGluZyAoVEhQIGluIGd1ZXN0IGFuZCBob3N0KSBpcyBn
b25lLiBUaGUgZ3Vlc3Qgd29uJ3QgYmUgYWJsZSB0byBtYWtlDQo+Pj4+Pj4+Pj4+Pj4+IHVzZSBv
ZiBUSFAgd2hlcmUgaXQgcHJldmlvdXNseSB3YXMgYWJsZSB0by4gSSBjYW4gaW1hZ2luZSB0aGlz
IGltcGxpZXMgYQ0KPj4+Pj4+Pj4+Pj4+PiBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiBmb3Igc29t
ZSB3b3JrbG9hZHMuIFRoaXMgbmVlZHMgYSBwcm9wZXINCj4+Pj4+Pj4+Pj4+Pj4gcGVyZm9ybWFu
Y2UgZXZhbHVhdGlvbi4NCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBJIHRoaW5rIHRoZSBw
cm9ibGVtIGlzIG1vcmUgd2l0aCB0aGUgYWxsb2NfcGFnZXMgQVBJLg0KPj4+Pj4+Pj4+Pj4+IFRo
YXQgZ2l2ZXMgeW91IGV4YWN0bHkgdGhlIGdpdmVuIG9yZGVyLCBhbmQgaWYgdGhlcmUncw0KPj4+
Pj4+Pj4+Pj4+IGEgbGFyZ2VyIGNodW5rIGF2YWlsYWJsZSwgaXQgd2lsbCBzcGxpdCBpdCB1cC4N
Cj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBCdXQgZm9yIGJhbGxvb24gLSBJIHN1c3BlY3Qg
bG90cyBvZiBvdGhlciB1c2VycywNCj4+Pj4+Pj4+Pj4+PiB3ZSBkbyBub3Qgd2FudCB0byBzdHJl
c3MgdGhlIHN5c3RlbSBidXQgaWYgYSBsYXJnZQ0KPj4+Pj4+Pj4+Pj4+IGNodW5rIGlzIGF2YWls
YWJsZSBhbnl3YXksIHRoZW4gd2UgY291bGQgaGFuZGxlDQo+Pj4+Pj4+Pj4+Pj4gdGhhdCBtb3Jl
IG9wdGltYWxseSBieSBnZXR0aW5nIGl0IGFsbCBpbiBvbmUgZ28uDQo+Pj4+Pj4+Pj4+Pj4gDQo+
Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gU28gaWYgd2Ugd2FudCB0byBhZGRyZXNzIHRoaXMs
IElNSE8gdGhpcyBjYWxscyBmb3IgYSBuZXcgQVBJLg0KPj4+Pj4+Pj4+Pj4+IEFsb25nIHRoZSBs
aW5lcyBvZg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+ICAgc3RydWN0IHBhZ2UgKmFsbG9j
X3BhZ2VfcmFuZ2UoZ2ZwX3QgZ2ZwLCB1bnNpZ25lZCBpbnQgbWluX29yZGVyLA0KPj4+Pj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBtYXhfb3JkZXIsIHVuc2lnbmVkIGlu
dCAqb3JkZXIpDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gdGhlIGlkZWEgd291bGQgdGhl
biBiZSB0byByZXR1cm4gYXQgYSBudW1iZXIgb2YgcGFnZXMgaW4gdGhlIGdpdmVuDQo+Pj4+Pj4+
Pj4+Pj4gcmFuZ2UuDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gV2hhdCBkbyB5b3UgdGhp
bms/IFdhbnQgdG8gdHJ5IGltcGxlbWVudGluZyB0aGF0Pw0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+PiBZb3UgY2FuIGp1c3Qgc3RhcnQgd2l0aCB0aGUgaGlnaGVzdCBvcmRlciBhbmQgZGVjcmVt
ZW50IHRoZSBvcmRlciB1bnRpbA0KPj4+Pj4+Pj4+Pj4geW91ciBhbGxvY2F0aW9uIHN1Y2NlZWRz
IHVzaW5nIGFsbG9jX3BhZ2VzKCksIHdoaWNoIHdvdWxkIGJlIGVub3VnaCBmb3INCj4+Pj4+Pj4+
Pj4+IGEgZmlyc3QgdmVyc2lvbi4gQXQgbGVhc3QgSSBkb24ndCBzZWUgdGhlIGltbWVkaWF0ZSBu
ZWVkIGZvciBhIG5ldw0KPj4+Pj4+Pj4+Pj4ga2VybmVsIEFQSS4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+
Pj4+Pj4+IE9LIEkgcmVtZW1iZXIgbm93LiAgVGhlIHByb2JsZW0gaXMgd2l0aCByZWNsYWltLiBV
bmxlc3MgcmVjbGFpbSBpcw0KPj4+Pj4+Pj4+PiBjb21wbGV0ZWx5IGRpc2FibGVkLCBhbnkgb2Yg
dGhlc2UgY2FsbHMgY2FuIHNsZWVwLiBBZnRlciBpdCB3YWtlcyB1cCwNCj4+Pj4+Pj4+Pj4gd2Ug
d291bGQgbGlrZSB0byBnZXQgdGhlIGxhcmdlciBvcmRlciB0aGF0IGhhcyBiZWNvbWUgYXZhaWxh
YmxlDQo+Pj4+Pj4+Pj4+IG1lYW53aGlsZS4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBZZXMsIGJ1
dCB0aGF04oCYcyBhIHB1cmUgb3B0aW1pemF0aW9uIElNSE8uDQo+Pj4+Pj4+Pj4gU28gSSB0aGlu
ayB3ZSBzaG91bGQgZG8gYSB0cml2aWFsIGltcGxlbWVudGF0aW9uIGZpcnN0IGFuZCB0aGVuIHNl
ZSB3aGF0IHdlIGdhaW4gZnJvbSBhIG5ldyBhbGxvY2F0b3IgQVBJLiBUaGVuIHdlIG1pZ2h0IGFs
c28gYmUgYWJsZSB0byBqdXN0aWZ5IGl0IHVzaW5nIHJlYWwgbnVtYmVycy4NCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gV2VsbCBob3cgZG8geW91IHByb3Bvc2UgaW1wbGVtZW50IHRoZSBuZWNlc3Nhcnkg
c2VtYW50aWNzPw0KPj4+Pj4+Pj4gSSB0aGluayB3ZSBhcmUgYm90aCBhZ3JlZWQgdGhhdCBhbGxv
Y19wYWdlX3JhbmdlIGlzIG1vcmUgb3INCj4+Pj4+Pj4+IGxlc3Mgd2hhdCdzIG5lY2Vzc2FyeSBh
bnl3YXkgLSBzbyBob3cgd291bGQgeW91IGFwcHJveGltYXRlIGl0DQo+Pj4+Pj4+PiBvbiB0b3Ag
b2YgZXhpc3RpbmcgQVBJcz8NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmFs
bG9vbl9jb21wYWN0aW9uLmggYi9pbmNsdWRlL2xpbnV4L2JhbGxvb25fY29tcGFjdGlvbi5oDQo+
Pj4+IA0KPj4+PiAuLi4uLg0KPj4+PiANCj4+Pj4gDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9tbS9i
YWxsb29uX2NvbXBhY3Rpb24uYyBiL21tL2JhbGxvb25fY29tcGFjdGlvbi5jDQo+Pj4+Pj4+IGlu
ZGV4IDI2ZGUwMjBhYWU3Yi4uMDY3ODEwYjMyODEzIDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9tbS9i
YWxsb29uX2NvbXBhY3Rpb24uYw0KPj4+Pj4+PiArKysgYi9tbS9iYWxsb29uX2NvbXBhY3Rpb24u
Yw0KPj4+Pj4+PiBAQCAtMTEyLDIzICsxMTIsMzUgQEAgc2l6ZV90IGJhbGxvb25fcGFnZV9saXN0
X2RlcXVldWUoc3RydWN0IGJhbGxvb25fZGV2X2luZm8gKmJfZGV2X2luZm8sDQo+Pj4+Pj4+IEVY
UE9SVF9TWU1CT0xfR1BMKGJhbGxvb25fcGFnZV9saXN0X2RlcXVldWUpOw0KPj4+Pj4+PiANCj4+
Pj4+Pj4gLyoNCj4+Pj4+Pj4gLSAqIGJhbGxvb25fcGFnZV9hbGxvYyAtIGFsbG9jYXRlcyBhIG5l
dyBwYWdlIGZvciBpbnNlcnRpb24gaW50byB0aGUgYmFsbG9vbg0KPj4+Pj4+PiAtICoJCQlwYWdl
IGxpc3QuDQo+Pj4+Pj4+ICsgKiBiYWxsb29uX3BhZ2VzX2FsbG9jIC0gYWxsb2NhdGVzIGEgbmV3
IHBhZ2UgKG9mIGF0IG1vc3QgdGhlIGdpdmVuIG9yZGVyKQ0KPj4+Pj4+PiArICogCQkJIGZvciBp
bnNlcnRpb24gaW50byB0aGUgYmFsbG9vbiBwYWdlIGxpc3QuDQo+Pj4+Pj4+ICAqDQo+Pj4+Pj4+
ICAqIERyaXZlciBtdXN0IGNhbGwgdGhpcyBmdW5jdGlvbiB0byBwcm9wZXJseSBhbGxvY2F0ZSBh
IG5ldyBiYWxsb29uIHBhZ2UuDQo+Pj4+Pj4+ICAqIERyaXZlciBtdXN0IGNhbGwgYmFsbG9vbl9w
YWdlX2VucXVldWUgYmVmb3JlIGRlZmluaXRpdmVseSByZW1vdmluZyB0aGUgcGFnZQ0KPj4+Pj4+
PiAgKiBmcm9tIHRoZSBndWVzdCBzeXN0ZW0uDQo+Pj4+Pj4+ICAqDQo+Pj4+Pj4+ICsgKiBXaWxs
IGZhbGwgYmFjayB0byBzbWFsbGVyIG9yZGVycyBpZiBhbGxvY2F0aW9uIGZhaWxzLiBUaGUgb3Jk
ZXIgb2YgdGhlDQo+Pj4+Pj4+ICsgKiBhbGxvY2F0ZWQgcGFnZSBpcyBzdG9yZWQgaW4gcGFnZS0+
cHJpdmF0ZS4NCj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+ICAqIFJldHVybjogc3RydWN0IHBhZ2UgZm9y
IHRoZSBhbGxvY2F0ZWQgcGFnZSBvciBOVUxMIG9uIGFsbG9jYXRpb24gZmFpbHVyZS4NCj4+Pj4+
Pj4gICovDQo+Pj4+Pj4+IC1zdHJ1Y3QgcGFnZSAqYmFsbG9vbl9wYWdlX2FsbG9jKHZvaWQpDQo+
Pj4+Pj4+ICtzdHJ1Y3QgcGFnZSAqYmFsbG9vbl9wYWdlc19hbGxvYyhpbnQgb3JkZXIpDQo+Pj4+
Pj4+IHsNCj4+Pj4+Pj4gLQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IGFsbG9jX3BhZ2UoYmFsbG9vbl9t
YXBwaW5nX2dmcF9tYXNrKCkgfA0KPj4+Pj4+PiAtCQkJCSAgICAgICBfX0dGUF9OT01FTUFMTE9D
IHwgX19HRlBfTk9SRVRSWSB8DQo+Pj4+Pj4+IC0JCQkJICAgICAgIF9fR0ZQX05PV0FSTik7DQo+
Pj4+Pj4+IC0JcmV0dXJuIHBhZ2U7DQo+Pj4+Pj4+ICsJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+Pj4+
Pj4+ICsNCj4+Pj4+Pj4gKwl3aGlsZSAob3JkZXIgPj0gMCkgew0KPj4+Pj4+PiArCQlwYWdlID0g
YWxsb2NfcGFnZXMoYmFsbG9vbl9tYXBwaW5nX2dmcF9tYXNrKCkgfA0KPj4+Pj4+PiArCQkJCSAg
IF9fR0ZQX05PTUVNQUxMT0MgfCBfX0dGUF9OT1JFVFJZIHwNCj4+Pj4+Pj4gKwkJCQkgICBfX0dG
UF9OT1dBUk4sIG9yZGVyKTsNCj4+Pj4+Pj4gKwkJaWYgKHBhZ2UpIHsNCj4+Pj4+Pj4gKwkJCXNl
dF9wYWdlX3ByaXZhdGUocGFnZSwgb3JkZXIpOw0KPj4+Pj4+PiArCQkJcmV0dXJuIHBhZ2U7DQo+
Pj4+Pj4+ICsJCX0NCj4+Pj4+Pj4gKwkJb3JkZXItLTsNCj4+Pj4+Pj4gKwl9DQo+Pj4+Pj4+ICsJ
cmV0dXJuIE5VTEw7DQo+Pj4+Pj4+IH0NCj4+Pj4+Pj4gLUVYUE9SVF9TWU1CT0xfR1BMKGJhbGxv
b25fcGFnZV9hbGxvYyk7DQo+Pj4+Pj4+ICtFWFBPUlRfU1lNQk9MX0dQTChiYWxsb29uX3BhZ2Vz
X2FsbG9jKTsNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IC8qDQo+Pj4+Pj4+ICAqIGJhbGxvb25fcGFnZV9l
bnF1ZXVlIC0gaW5zZXJ0cyBhIG5ldyBwYWdlIGludG8gdGhlIGJhbGxvb24gcGFnZSBsaXN0Lg0K
Pj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IEkgdGhpbmsgdGhpcyB3aWxsIHRyeSB0byBpbnZva2Ug
ZGlyZWN0IHJlY2xhaW0gZnJvbSB0aGUgZmlyc3QgaXRlcmF0aW9uDQo+Pj4+Pj4gdG8gZnJlZSB1
cCB0aGUgbWF4IG9yZGVyLg0KPj4+Pj4gDQo+Pj4+PiAlX19HRlBfTk9SRVRSWTogVGhlIFZNIGlt
cGxlbWVudGF0aW9uIHdpbGwgdHJ5IG9ubHkgdmVyeSBsaWdodHdlaWdodA0KPj4+Pj4gbWVtb3J5
IGRpcmVjdCByZWNsYWltIHRvIGdldCBzb21lIG1lbW9yeSB1bmRlciBtZW1vcnkgcHJlc3N1cmUg
KHRodXMgaXQNCj4+Pj4+IGNhbiBzbGVlcCkuIEl0IHdpbGwgYXZvaWQgZGlzcnVwdGl2ZSBhY3Rp
b25zIGxpa2UgT09NIGtpbGxlci4NCj4+Pj4+IA0KPj4+Pj4gQ2VydGFpbmx5IGdvb2QgZW5vdWdo
IGZvciBhIGZpcnN0IHZlcnNpb24gSSB3b3VsZCBzYXksIG5vPw0KPj4+PiANCj4+Pj4gRnJhbmts
eSBob3cgd2VsbCB0aGF0IGJlaGF2ZXMgd291bGQgZGVwZW5kIGEgbG90IG9uIHRoZSB3b3JrbG9h
ZC4NCj4+Pj4gQ2FuIHJlZ3Jlc3MganVzdCBhcyB3ZWxsLg0KPj4+PiANCj4+Pj4gRm9yIHRoZSAx
c3QgdmVyc2lvbiBJJ2QgcHJlZmVyIHNvbWV0aGluZyB0aGF0IGlzIHRoZSBsZWFzdCBkaXNydXB0
aXZlLA0KPj4+PiBhbmQgdGhhdCBJTUhPIG1lYW5zIHdlIG9ubHkgdHJpZ2dlciByZWNsYWltIGF0
IGFsbCBpbiB0aGUgc2FtZSBjb25maWd1cmF0aW9uDQo+Pj4+IGFzIG5vdyAtIHdoZW4gd2UgY2Fu
J3Qgc2F0aXNmeSB0aGUgbG93ZXN0IG9yZGVyIGFsbG9jYXRpb24uDQo+Pj4gDQo+Pj4gQWdyZWVk
Lg0KPj4+IA0KPj4+PiBBbnl0aGluZyBlbHNlIHdvdWxkIGJlIGEgaHVnZSBhbW91bnQgb2YgdGVz
dGluZyB3aXRoIGFsbCBraW5kIG9mDQo+Pj4+IHdvcmtsb2Fkcy4NCj4+PiANCj4+PiBTbyBkb2lu
ZyBhICImIH5fX0dGUF9SRUNMQUlNIiBpbiBjYXNlIG9yZGVyID4gMD8gKGFzIGRvbmUgaW4NCj4+
PiBHRlBfVFJBTlNIVUdFX0xJR0hUKQ0KPj4gDQo+PiBUaGF0IHdpbGwgaW1wcm92ZSB0aGUgc2l0
dWF0aW9uIHdoZW4gcmVjbGFpbSBpcyBub3QgbmVlZGVkLCBidXQgbGVhdmUNCj4+IHRoZSBwcm9i
bGVtIGluIHBsYWNlIGZvciB3aGVuIGl0J3MgbmVlZGVkOiBpZiByZWNsYWltIGRvZXMgdHJpZ2dl
ciwgd2UNCj4+IGNhbiBnZXQgYSBodWdlIGZyZWUgcGFnZSBhbmQgaW1tZWRpYXRlbHkgYnJlYWsg
aXQgdXAuDQo+PiANCj4+IFNvIGl0J3Mgb2sgYXMgYSBmaXJzdCBzdGVwIGJ1dCBpdCB3aWxsIG1h
a2UgdGhlIHNlY29uZCBzdGVwIGhhcmRlciBhcw0KPj4gd2UnbGwgbmVlZCB0byB0ZXN0IHdpdGgg
cmVjbGFpbSA6KS4NCj4gDQo+IEkgZXhwZWN0IHRoZSB3aG9sZSAic3RlYWwgaHVnZSBwYWdlcyBm
cm9tIHlvdXIgZ3Vlc3QiIHRvIGJlIHByb2JsZW1hdGljLA0KPiBhcyBJIGFscmVhZHkgbWVudGlv
bmVkIHRvIEFsZXguIFRoaXMgbmVlZHMgYSBwZXJmb3JtYW5jZSBldmFsdWF0aW9uLg0KPiANCj4g
VGhpcyBhbGwgc21lbGxzIGxpa2UgYSBsb3Qgb2Ygd29ya2xvYWQgZGVwZW5kZW50IGZpbmUtdHVu
aW5nLiA6KQ0KDQpBRkFJSyB0aGUgaGFyZHdhcmUgb3ZlcmhlYWRzIG9mIGtlZXBpbmcgaHVnZS1w
YWdlcyBpbiB0aGUgZ3Vlc3QgYW5kIGJhY2tpbmcNCnRoZW0gd2l0aCA0S0IgcGFnZXMgYXJlIG5v
bi1uZWdsaWdpYmxlLiBEaWQgeW91IHRha2UgdGhvc2UgaW50byBhY2NvdW50Pw0KDQo=

