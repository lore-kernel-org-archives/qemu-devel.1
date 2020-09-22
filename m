Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612D7C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9590206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MTzgo+He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9590206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpW9-0000ch-LI
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kKoT4-0003FN-9S
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:00:51 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com
 ([40.107.223.45]:3457 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kKoT1-0005aZ-PU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8Kiri1kRjBdDiJhzF5cSaFokv+bnM1C5JqCtKzR6sqj2MhzX+CTcR9FN6uS3QGfdIku5uaok51qSOkyq544dEZtwIWU2PFoxq/t+KrpKW7V774s+WMFXR4zfuTjK53aO1eX9GTZQ9zK+B33gAoYepxZAqOvXq1E7RFe21gPiiqDEKXt4VMlxVaAdDtpd40tevbqQO9TlK/KSx5txPxNTPTeP0PHBH0o3jWt6F1orSLabfH0ml2QVPEsMwOMHLOzMePxnU0KgwGrnMtpLatHAmY/k61rbQlf1f3nSqPbBWYhJDwIlyEHZ5FnJ8+GUd5GCfFFRLUReF0s/G6SVhA6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPc9fvXf717luLjNkiudQItQnH5zTr8PNKXbATgdAMA=;
 b=XGs/HFZjMMudiI1aeuutdcQbFmOt6Zw6TbTgY8tHkPWZcodrq9F1ketq3JKJv7CywIz453S6SmR6RRNw1NRPg+SUbFnxIxUMJ9Hz7ZksJHPgM34KUaUF5c+aIG1EVNKm2NiIR4B3ZXpqB1zMzoYxguhwICsYIhtcYw8hOCEG0C+cZjD/2oSEwwXmwOSlKlbRmqxEKPVtN2IV53uEit9Y3nfwKnAJWXzox9gq8EbKQYjGPWRcc5DOxgokfCt8BiCgtIsAieg+1U4PrcdmR4itHO5lXAoWvEvlrAXGT2/5ffPzikLWaI5WqUfXjTWIDXCe5QgKWwcYjftoiky17ZpC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPc9fvXf717luLjNkiudQItQnH5zTr8PNKXbATgdAMA=;
 b=MTzgo+He052s/z5+sXo6ulFJWJls6OTQ9eCZkchYb8GyqmdtrQMDZSQsuMOHFAlkhScCZDEOrigcKxCoTLouGcSxqLULiDf613ohv6Jk95HgqZBe0iAP60bdbfGpnRww+aa2hadlDmNXML7UliSbI+MCz8Z9q6k5TswNQ8V41BA=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 19:45:42 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 19:45:42 +0000
From: "Kalra, Ashish" <Ashish.Kalra@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: SEV guest debugging support for Qemu
Thread-Topic: SEV guest debugging support for Qemu
Thread-Index: AdaRFDK3audkmeWoQf+wUmHmEb1piw==
Date: Tue, 22 Sep 2020 19:45:42 +0000
Message-ID: <SN6PR12MB2767F50558B296B1A7354E668E3B0@SN6PR12MB2767.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T18:39:58Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4355470a-d1ba-4f21-ad72-00000d61ea69;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T19:45:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b4d69f3d-4d04-494e-9e51-00008815017b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.78.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1d198e9-4861-44d3-33a4-08d85f301754
x-ms-traffictypediagnostic: SA0PR12MB4382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB43822FE3B9C4FFDB48DB50B38E3B0@SA0PR12MB4382.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVbzT8I2KX95TA/lXiVzvEwshPp+b5HuRbwdkJZ4uxb3gvaZiFKsZg/Xjb84VlkPvwnQK0Uc8fi2dj6cJF6zOHFEntXtyI/s3EZiMnQm6o48YEc7/hRndVN2xcrdm0ovW/iPeAa+n0t7jQC0ooBzA1dJ1S4lB49T0pvN6Pf4INQwUwq1tPF2dzyOzAUwGg0R6BB6ahwh8uzqKTPkY8hgQQl5stxiU6Man4dL5DnHonwRxS9WKNLNsZxYjVfZFfEOut84tM0PzEDk9vd77U3C+4WcBSjUB2AORf2vERQrR1mYlI9EinrhV6tyelU7MaBy2nQzyXCU8YjO7iZO7AnGV+fs4c2v44srll91yXr6vyeOUwV7zRj9J5uwMsTTAdHxJ23SNK4I+WJSva8hQUUQ37CqlfoNPCP/CKbdUWJ8xIg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(7696005)(4326008)(8936002)(66476007)(64756008)(66946007)(54906003)(66446008)(71200400001)(110136005)(33656002)(966005)(26005)(316002)(186003)(66556008)(76116006)(8676002)(6506007)(86362001)(52536014)(2906002)(83380400001)(166002)(5660300002)(478600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 32dI5HJMUG5ZVtwKsIdrBrjtFHAWI6d7pS1iV6VGFrldM1Gk9kafgO2yupYrE+rZQtUphrRw91Pamy2UQOTDxfuomUvHuJXfHkGrcrsv9yqD1k9NONWs3jRWMF3XBiQfD7BOY9jlbovNTZlLsBeM3VBOeZW4x0a4/ILOZpjWvoVSEF35tDpJ0HI6VgeY6eSKLVx8guQCG7GJXhmyqy55FJugkEHNbwNTXE1U5QuWs3XtjkLktwvPrtBXw2/pIkAZ4lIOr1cQNJiPy3uOdk4oSo+hsOwVt1MYSBoKApkJ0/soeV7RaJJ0a5t+WoEX9W8DznWWGqOESPKdDZ7oBi3IgMhkFmCnSWGOXd1gXwNqzcxnbEJVfbBM6AVdLm6+Bedo1pOvG0uWZCvI8Fl9SaSyO33Gk0OArhNyek6N7JHqvHpi4q6ViDsw0Xk2Q/RCfBYjCDGPkWXzVLp6SPSOCg0B1J3PM3PskJK+o0aNaVMeH/OXuMYlhhPnImJB+Y9F9XJdjvPz71r1WFvr4uFw3AHzlkEzw18eWu5wu/bv64R3amaIW8N5rWUzRFffGK7rVWn/W6YUq/qjnNJLwm8OJBgqI/M0G7SqeHTx3KW6NTcRMRNmNmafKQggAhGXsyTn2TTdjdJkvunRKZV7UTNVZKdheg==
Content-Type: multipart/alternative;
 boundary="_000_SN6PR12MB2767F50558B296B1A7354E668E3B0SN6PR12MB2767namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d198e9-4861-44d3-33a4-08d85f301754
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 19:45:42.5389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxBPo0m8EaKC5sq5XU7UUBO8+X2X9W8Kr4w3IW0xDh7k9RbkVHEItTLs4vHTJ4TFOQhBQa1w+aN7A06mm1E9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Received-SPF: none client-ip=40.107.223.45; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 16:00:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2020 16:57:09 -0400
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
Cc: "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Grimm, Jon" <Jon.Grimm@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_SN6PR12MB2767F50558B296B1A7354E668E3B0SN6PR12MB2767namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hello Alan, Paolo,
I am following up on Brijesh's patches for SEV guest debugging support for =
Qemu using gdb and/or qemu monitor.
I believe that last time, Qemu SEV debug patches were not applied and have =
attached the link to the email thread and Paolo's feedback below for refere=
nce [1].
I wanted to re-start a discussion on the same here with the Qemu community =
and seek the feedback on the approaches which we are considering :

Looking at Qemu code, I see the following interface is defined, for virtual=
 memory access for debug : cpu_memory_rw_debug().

Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memo=
ry_dump() ) use this standard and well-defined interface to access guest me=
mory for debugging purposes.



This internally invokes the address_space_rw() accessor functions which we =
had  "fixed" internally (as part of the earlier patch) to invoke memory reg=
ion specific debug ops.

In our earlier approach we were adding debug ops/callbacks to memory region=
s and as per comments on our earlier patches, Paolo was not happy with this=
 debug API for

MemoryRegions and hence the SEV support for Qemu was merged without the deb=
ug support.

Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively=
 introduce a new generic debug interface/object in the Qemu. This

debug interface should be controlled through the global machine policy.



For e.g.,

# $QEMU -machine -debug=3D<a debug object>

or

# $QEMU -machine -debug=3Dsev-guest-debug



The QMP and GDB access will be updated to use the generic debug  interface.=
 The generic debug interface or the cpu_memory_rw_debug() interace will int=
roduce hooks to call a

vendor specific debug object to delegate accessing the data. The vendor spe=
cific debug object may do a further checks before and after accessing the m=
emory.



Now, looking specifically at cpu_memory_rw_debug() interface, this interfac=
e is invoked for all guest memory accesses for debugging purposes and it al=
so does

guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can =
again add a vendor specific callback here to do guest VA to GPA translation=
s specific

to SEV as SEV guest debugging will also require accessing guest page table =
entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally c=
learing

the C-bit on page table entries (PxEs) before using them further for page t=
able walks.



There is still an issue with the generic cpu_memory_rw_debug() interface, t=
hough it is used for all guest memory accesses for debugging and we can als=
o handle

guest page table walks via it (as mentioned above), there are still other g=
db/monitor commands such as tlb_info_xx() and mem_info_xx() which also do g=
uest page

table walks, but they don't go through any generic guest memory access/debu=
g interface, so these commands will need to be handled additionally for SEV=
.



The vendor specific debug object (added as a hook to generic debug object o=
r the generic cpu_memory_rw_debug() interface) will do further checks befor=
e and after accessing the memory.



e.g., in the case of SEV,



1. Check the guest policy, if guest policy does not allow debug then return=
 an error.



2. If its an MMIO region then access the data.



3. If its RAM region then call the PSP commands to decrypt the data.



4. If caller asked to read the PTE entry then probably clear the C-bits aft=
er reading the PTE entry.



5. many more checks



Looking fwd. to your feedback/comments on the above approach or other any o=
ther suggestions.



Thanks,

Ashish

[1] -> http://next.patchew.org/QEMU/20180308124901.83533-1-brijesh.singh@am=
d.com/20180308124901.83533-29-brijesh.singh@amd.com/

--_000_SN6PR12MB2767F50558B296B1A7354E668E3B0SN6PR12MB2767namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:7.5pt;background:white;word-b=
reak:break-all">
<span style=3D"font-size:10.0pt;color:#333333">Hello Alan, Paolo,<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:7.5pt;background:white;word-b=
reak:break-all">
<span style=3D"font-size:10.0pt;color:#333333">I am following up on Brijesh=
&#8217;s patches for SEV guest debugging support for Qemu using gdb and/or =
qemu monitor.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:7.5pt;background:white;word-b=
reak:break-all">
<span style=3D"font-size:10.0pt;color:#333333">I believe that last time, Qe=
mu SEV debug patches were not applied and have attached the link to the ema=
il thread and Paolo&#8217;s feedback below for reference [1].<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:7.5pt;background:white;word-b=
reak:break-all">
<span style=3D"font-size:10.0pt;color:#333333">I wanted to re-start a discu=
ssion on the same here
</span><span style=3D"font-size:10.0pt;color:black">with the Qemu community=
 and seek the feedback on the approaches which we are considering :</span><=
span style=3D"font-size:10.0pt;color:#333333"><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Looking at Qemu =
code, I see the following interface is defined, for virtual memory access f=
or debug : cpu_memory_rw_debug().
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Both gdbstub (ta=
rget_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use =
this standard and well-defined interface to access guest memory for debuggi=
ng purposes.
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">This internally =
invokes the address_space_rw() accessor functions which we had &nbsp;&quot;=
fixed&quot; internally (as part of the earlier patch) to invoke memory regi=
on specific debug ops.
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">In our earlier a=
pproach we were adding debug ops/callbacks to memory regions and as per com=
ments on our earlier patches, Paolo was not happy with this debug API for<o=
:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">MemoryRegions an=
d hence the SEV support for Qemu was merged without the debug support.<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Now, we want to =
reuse this cpu_memory_rw_debug() interface or alternatively introduce a new=
 generic debug interface/object in the Qemu. This
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">debug interface =
should be controlled through the global machine policy.<o:p></o:p></span></=
p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">For e.g., <o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"># $QEMU -machine=
 -debug=3D&lt;a debug object&gt;<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">or<o:p></o:p></s=
pan></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"># $QEMU -machine=
 -debug=3Dsev-guest-debug<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">The QMP and GDB =
access will be updated to use the generic debug &nbsp;interface. The generi=
c debug interface or the cpu_memory_rw_debug() interace will introduce hook=
s to call a
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">vendor specific =
debug object to delegate accessing the data. The vendor specific debug obje=
ct may do a further checks before and after accessing the memory.<o:p></o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Now, looking spe=
cifically at cpu_memory_rw_debug() interface, this interface is invoked for=
 all guest memory accesses for debugging purposes and it also does
<o:p></o:p></span></p>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">guest VA to=
 GPA translation via <span style=3D"color:black">cpu_get_phys_page_attrs_de=
bug(), so we can again add a vendor specific callback here to do guest VA t=
o GPA translations specific<o:p></o:p></span></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>to SEV as SEV guest debugging will also require accessing guest page table=
 entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally =
clearing<o:p></o:p></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>the C-bit on page table entries (PxEs) before using them further for page =
table walks.<o:p></o:p></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
><o:p>&nbsp;</o:p></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>There is still an issue with the generic cpu_memory_rw_debug() interface, =
though it is used for all guest memory accesses for debugging and we can al=
so handle<o:p></o:p></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>guest page table walks via it (as mentioned above), there are still other =
gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do =
guest page<o:p></o:p></span></pre>
<pre><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>table walks, but they don&#8217;t go through any generic guest memory acce=
ss/debug interface, so these commands will need to be handled additionally =
for SEV.<o:p></o:p></span></pre>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">The vendor speci=
fic debug object (added as a hook to generic debug object or the generic cp=
u_memory_rw_debug() interface) will do further checks before and after acce=
ssing the memory.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">e.g., in the cas=
e of SEV,<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">1. Check the gue=
st policy, if guest policy does not allow debug then return an error.<o:p><=
/o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">2. If its an MMI=
O region then access the data.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">3. If its RAM re=
gion then call the PSP commands to decrypt the data.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">4. If caller ask=
ed to read the PTE entry then probably clear the C-bits after reading the P=
TE entry.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">5. many more che=
cks<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Looking fwd. to =
your feedback/comments on the above approach or other any other suggestions=
.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Thanks,<o:p></o:=
p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:10.0pt">Ashish<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">[1] -&gt; <a href=
=3D"http://next.patchew.org/QEMU/20180308124901.83533-1-brijesh.singh@amd.c=
om/20180308124901.83533-29-brijesh.singh@amd.com/">
http://next.patchew.org/QEMU/20180308124901.83533-1-brijesh.singh@amd.com/2=
0180308124901.83533-29-brijesh.singh@amd.com/</a></span><o:p></o:p></p>
</div>
</body>
</html>

--_000_SN6PR12MB2767F50558B296B1A7354E668E3B0SN6PR12MB2767namp_--

