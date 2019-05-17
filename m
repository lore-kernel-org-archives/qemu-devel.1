Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADBFC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A634206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="RpwnGuZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A634206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eltan.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXoB-0001Vq-Fg
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:01:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hRXmo-00013e-5Y
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hRXmm-0001u1-Lh
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:00:14 -0400
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:62103)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>)
	id 1hRXml-0001o0-TF; Fri, 17 May 2019 04:00:12 -0400
Received: from cpsps-ews25.kpnxchange.com ([10.94.84.191]) by
	cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514); 
	Fri, 17 May 2019 09:47:04 +0200
X-Brand: 7Ljiz6bi2A==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
	te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=RugU0xuK c=1 sm=1 tr=0 cx=a_idp_e
	a=dZ5u/0G9QtS9WKCcNUBnHQ==:117 a=dZ5u/0G9QtS9WKCcNUBnHQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=eIHzyqS2sMcA:10 a=xqWC_Br6kY4A:10
	a=E5NmQfObTbMA:10 a=X5F7dNyOAAAA:8 a=aow-egSQAAAA:8
	a=T2qGinoh8z3atOZns1kA:9 a=wPNLvfGTeEIA:10 a=90inoWJPefa_d6n_ja4A:9
	a=B2y7HmGcmWMA:10 a=pS7LufLo7ZPxIL5li5Lt:22 a=gFNbaldVC-z-bsjSTzMo:22
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.13]) by cpsps-ews25.kpnxchange.com
	over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	Fri, 17 May 2019 09:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:content-type:message-id:date:subject:to:from;
	bh=eK32PG2oslASve83mQgd2mZgaUQaVXOkvc1Gt3bmZyc=;
	b=RpwnGuZKWiBqRkFt5hv5ZmgnuYdjCT22zncbKMPhpld0L7J69Fn/52z6ctOpUvmneEmAHmI5KMkuk
	qAcWVrDSaraJPfSPAhJup17IjTQXtwC2VO4/DyChRZwY/esh+K+dWI18phyZaIANxk+sbBxJ0jzvpD
	ZN21zvnDohb6JJfU=
Received: from Eltsrv03.Eltan.local (unknown [84.85.114.86])
	by smtp.kpnmail.nl (Halon) with ESMTPS
	id f66c8bd2-7877-11e9-89e3-005056998788;
	Fri, 17 May 2019 09:47:04 +0200 (CEST)
Received: from Eltsrv03.Eltan.local (192.168.100.3) by Eltsrv03.Eltan.local
	(192.168.100.3) with Microsoft SMTP Server (TLS) id 15.0.847.32;
	Fri, 17 May 2019 09:46:29 +0200
Received: from Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8]) by
	Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8%12]) with mapi id
	15.00.0847.040; Fri, 17 May 2019 09:46:10 +0200
From: Wim Vervoorn <wvervoorn@eltan.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>
Thread-Topic: aspeed qemu question
Thread-Index: AdULwnm8cADYiO1ZRNGvxixzeWIzuQAJZaCAACbA8VA=
Date: Fri, 17 May 2019 07:46:10 +0000
Message-ID: <108c97d2eee749da8f75c69f06e25072@Eltsrv03.Eltan.local>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<eb815dd0-f056-d733-f017-bba56b907231@kaod.org>
In-Reply-To: <eb815dd0-f056-d733-f017-bba56b907231@kaod.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.100.108]
Content-Type: multipart/mixed;
	boundary="_002_108c97d2eee749da8f75c69f06e25072Eltsrv03Eltanlocal_"
MIME-Version: 1.0
X-OriginalArrivalTime: 17 May 2019 07:47:04.0434 (UTC)
	FILETIME=[B8498520:01D50C84]
X-RcptDomain: nongnu.org
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 213.75.39.10
Subject: Re: [Qemu-devel] aspeed qemu question
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_002_108c97d2eee749da8f75c69f06e25072Eltsrv03Eltanlocal_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Cedr=EDc,

Thanks for your response. I created and attached the patch. You are right t=
he code snipped turns out unreadable.

In the patch I enable the MAC's depending on the value in hwstrap1 just as =
in the real hardware. In the Palmetto both nics will be enabled (just as in=
 the real palmetto).=20

I added a 2nd AST2400 BMC the Eltan Piestewa Peak. Here I enabled the 2nd N=
IC only.

What I see is that when I use Palmetto I get an assert in net/net.c line 25=
6, this is in the "qemu_net_client_setup()". I assume I have to prepare som=
ething regarding the host side of the network implementation but I this poi=
nt I have no clue what and I have a hard time figuring out how the networki=
ng architecture really works.=20

If you could point me in the right direction I would really appreciate it.

Best Regards,
Wim Vervoorn

Eltan B.V.
Ambachtstraat 23
5481 SM Schijndel
The Netherlands

T : +31-(0)73-594 46 64
E : wvervoorn@eltan.com
W : http://www.eltan.com


-----Original Message-----
From: C=E9dric Le Goater [mailto:clg@kaod.org]=20
Sent: Thursday, May 16, 2019 5:06 PM
To: Wim Vervoorn <wvervoorn@eltan.com>
Subject: Re: aspeed qemu question

Hello Wim,

On 5/16/19 10:46 AM, Wim Vervoorn wrote:
> Hello C=E9dric,
>=20
> =A0
>=20
> I noticed you are responsible for most of the Aspeed additions to Qemu pe=
rhaps you can help me.

Sure,

> =A0
>=20
> I am trying to add support for the 2^nd NIC on the Aspeed SoC.

ok. This should be possible.=20

> This seemed not that hard. Basically I added a 2^nd structure for the dev=
ice and initialized that. I included the code below.

hmm. This is difficult for me to read. Do you know how to send patches ? =20

It would be good to send a patch to the QEMU devel and the QEMU ARM mailing=
 list so that we can discuss openly.

I can help you doing that.=20

=20
Cheers,

C.

> The code is building fine no problem about that.
>=20
> =A0
>=20
> The issue is that I get an assert net.c line 256, this only happens if I =
realize both NICs if I realize only one all works as expected. My question =
is, am I overlooking something here? Do I need to take more actions to be a=
ble to support the 2^nd NIC? If you could point me in the right direction o=
r know where I can find more information on the qemu architecture I would r=
eally appreciate it.
>=20
> =A0
>=20
> =A0
>=20
> =A0
>=20
> staticvoidqemu_net_client_setup(NetClientState *nc,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 NetClientInfo *info,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 NetClientState *peer,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 constchar*model,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 constchar*name,
>=20
> =A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0NetClientDestructor *destructor)
>=20
> {
>=20
> =A0=A0=A0 nc->info=3D info;
>=20
> =A0=A0=A0 nc->model=3D g_strdup(model);
>=20
> =A0=A0=A0 if(name) {
>=20
> =A0=A0=A0=A0=A0=A0=A0 nc->name=3D g_strdup(name);
>=20
> =A0=A0=A0 } else{
>=20
> =A0=A0=A0=A0=A0=A0=A0 nc->name=3D assign_name(nc, model);
>=20
> =A0=A0=A0 }
>=20
> =A0
>=20
> =A0=A0=A0 if(peer) {
>=20
> =E0>=A0=A0=A0=A0 assert(!peer->peer);
>=20
> =A0=A0=A0=A0=A0=A0=A0 nc->peer=3D peer;
>=20
> =A0=A0=A0=A0=A0=A0=A0 peer->peer=3D nc;
>=20
> =A0=A0=A0 }
>=20
> =A0
>=20
> =A0
>=20
> =A0=A0=A0 object_initialize(&s->ftgmac100[0], sizeof(s->ftgmac100),=20
> TYPE_FTGMAC100);
>=20
> =A0=A0=A0 object_property_add_child(obj, "ftgmac100[0]",=20
> OBJECT(&s->ftgmac100[0]), NULL);
>=20
> =A0=A0=A0 qdev_set_parent_bus(DEVICE(&s->ftgmac100[0]),=20
> sysbus_get_default());
>=20
> =A0
>=20
> =A0=A0=A0 object_initialize(&s->ftgmac100[1], sizeof(s->ftgmac100),=20
> TYPE_FTGMAC100);
>=20
> =A0=A0=A0 object_property_add_child(obj, "ftgmac100[1]",=20
> OBJECT(&s->ftgmac100[1]), NULL);
>=20
> =A0=A0=A0 qdev_set_parent_bus(DEVICE(&s->ftgmac100[1]),=20
> sysbus_get_default());
>=20
> =A0
>=20
> =A0
>=20
> =A0
>=20
> /* Net LAN 0*/
>=20
> =A0=A0=A0 #if(0)
>=20
> =A0=A0=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: LAN0\n", __func__);
>=20
> =A0=A0=A0 qdev_set_nic_properties(DEVICE(&s->ftgmac100[0]), &nd_table[0])=
;
>=20
> =A0=A0=A0 object_property_set_bool(OBJECT(&s->ftgmac100[0]), true, "aspee=
d",=20
> &err);
>=20
> =A0=A0=A0 object_property_set_bool(OBJECT(&s->ftgmac100[0]), true,=20
> "realized",
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &local_err);
>=20
> =A0=A0=A0 error_propagate(&err, local_err);
>=20
> =A0=A0=A0 if (err) {
>=20
> =A0=A0=A0=A0=A0=A0=A0 error_propagate(errp, err);
>=20
> =A0=A0=A0=A0=A0=A0=A0 return;
>=20
> =A0=A0=A0 }
>=20
> =A0=A0=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0,=20
> ASPEED_SOC_ETH1_BASE);
>=20
> =A0=A0=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qdev_g=
et_gpio_in(DEVICE(&s->vic), 2));
>=20
> =A0=A0=A0 #endif
>=20
> =A0
>=20
> =A0=A0=A0 /* Net LAN 1*/
>=20
> =A0=A0=A0 #if(1)
>=20
> =A0=A0=A0 qemu_log_mask(LOG_GUEST_ERROR, "%s: LAN1\n", __func__);
>=20
> =A0=A0=A0 qdev_set_nic_properties(DEVICE(&s->ftgmac100[1]), &nd_table[1])=
;
>=20
> =A0=A0=A0 object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "aspee=
d",=20
> &err);
>=20
> =A0=A0=A0 object_property_set_bool(OBJECT(&s->ftgmac100[1]), true,=20
> "realized",
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &local_err);
>=20
> =A0=A0=A0 error_propagate(&err, local_err);
>=20
> =A0=A0=A0 if(err) {
>=20
> =A0=A0=A0=A0=A0=A0=A0 error_propagate(errp, err);
>=20
> =A0=A0=A0=A0=A0=A0=A0 return;
>=20
> =A0=A0=A0 }
>=20
> =A0=A0=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0,=20
> ASPEED_SOC_ETH2_BASE);
>=20
> =A0=A0=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qdev_g=
et_gpio_in(DEVICE(&s->vic), 3));
>=20
> =A0=A0=A0 #endif
>=20
> =A0
>=20
> =A0
>=20
> Best Regards,
>=20
> Wim Vervoorn
>=20
> =A0
>=20
> Eltan B.V.
>=20
> Ambachtstraat 23
>=20
> 5481 SM Schijndel
>=20
> The Netherlands
>=20
> =A0
>=20
> T : +31-(0)73-594 46 64
>=20
> E : wvervoorn@eltan.com
>=20
> W : http://www.eltan.com <http://www.eltan.com/>
>=20
> =A0
>=20
> =A0
>=20
> "THIS MESSAGE CONTAINS CONFIDENTIAL INFORMATION. UNLESS YOU ARE THE=20
> INTENDED RECIPIENT OF THIS MESSAGE, ANY USE OF THIS MESSAGE IS STRICTLY P=
ROHIBITED. IF YOU HAVE RECEIVED THIS MESSAGE IN ERROR, PLEASE IMMEDIATELY N=
OTIFY THE SENDER BY TELEPHONE +31-(0)73-5944664 OR REPLY EMAIL, AND IMMEDIA=
TELY DELETE THIS MESSAGE AND ALL COPIES."
>=20
> =A0
>=20




--_002_108c97d2eee749da8f75c69f06e25072Eltsrv03Eltanlocal_
Content-Type: application/octet-stream;
	name="0002-ASPEED-BMC-Add-support-for-2nd-NIC.patch"
Content-Description: 0002-ASPEED-BMC-Add-support-for-2nd-NIC.patch
Content-Disposition: attachment;
	filename="0002-ASPEED-BMC-Add-support-for-2nd-NIC.patch"; size=7278;
	creation-date="Fri, 17 May 2019 07:43:06 GMT";
	modification-date="Fri, 17 May 2019 07:34:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYmY5MzkyYjg0ZjM4NTMxYjg5ZTRlYTM5ZTA2MjEwYjk5ZWM3YTBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YmJmOTM5MmI4NGYzODUzMWI4OWU0ZWEzOWUwNjIx
MGI5OWVjN2EwYy4xNTU4MDc4NDYzLmdpdC53dmVydm9vcm5AZWx0YW4uY29tPgpGcm9tOiBXaW0g
VmVydm9vcm4gPHd2ZXJ2b29ybkBlbHRhbi5jb20+CkRhdGU6IEZyaSwgMTcgTWF5IDIwMTkgMDk6
MjY6MTYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBBU1BFRUQgQk1DOiBBZGQgc3VwcG9ydCBmb3Ig
Mm5kIE5JQwoKQWRkIHN1cHBvcnQgZm9yIDJuZCBOSUMuCgpUaGlzIHNvbHV0aW9uIGlzIHVzaW5n
IHRoZSBod3N0cmFwMSB2YWx1ZSB0byBlbmFibGUgZGlzYWJsZSB0aGUKY29udHJvbGxlcnMuCgpU
aGUgUGFsbWV0dG8gbGVhdmVzIGJvdGggTklDcyBlbmFibGVkIHdoaWxlIHRoZSBQaWVzdGV3YSBQ
ZWFrIG9ubHkKZW5hYmxlcyBvbmUuCgpUaGUgUGFsbWV0dG8gYXNzZXJ0cyBpbiBuZXQvbmV0LmMg
bGluZSAyNTYgd2hlbiBxZW11IHN0YXJ0cyBzbyBzb21ldGhpbmcKbXVzdCBiZSBtaXNzaW5nIHRv
IHN1cHBvcnQgdGhlIDJuZCBuaWMuCi0tLQogaHcvYXJtL2FzcGVlZC5jICAgICAgICAgICAgIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKwogaHcvYXJtL2FzcGVlZF9zb2MuYyAgICAgICAgIHwg
NTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiBpbmNsdWRl
L2h3L2FybS9hc3BlZWRfc29jLmggfCAgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9o
dy9hcm0vYXNwZWVkLmMKb2xkIG1vZGUgMTAwNjQ0Cm5ldyBtb2RlIDEwMDc1NQppbmRleCAwMjAz
NjQyLi5mOTU3YTViCi0tLSBhL2h3L2FybS9hc3BlZWQuYworKysgYi9ody9hcm0vYXNwZWVkLmMK
QEAgLTQzLDYgKzQzLDIzIEBAIHN0cnVjdCBBc3BlZWRCb2FyZFN0YXRlIHsKICAgICAgICAgU0NV
X0FTVDI0MDBfSFdfU1RSQVBfU0VUX0NMS19TT1VSQ0UoQVNUMjQwMF9DTEtfNDhNX0lOKSB8ICAg
ICAgIFwKICAgICAgICAgU0NVX0hXX1NUUkFQX1ZHQV9DTEFTU19DT0RFIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgU0NVX0hXX1NUUkFQX0xQQ19SRVNFVF9Q
SU4gfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0hX
X1NUUkFQX01BQzBfUkdNSUkgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKKyAgICAgICAgU0NVX0hXX1NUUkFQX01BQzFfUkdNSUkgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0hXX1NUUkFQX1NQSV9NT0RFKFNDVV9I
V19TVFJBUF9TUElfTV9TX0VOKSB8ICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0FTVDI0
MDBfSFdfU1RSQVBfU0VUX0NQVV9BSEJfUkFUSU8oQVNUMjQwMF9DUFVfQUhCX1JBVElPXzJfMSkg
fCBcCisgICAgICAgIFNDVV9IV19TVFJBUF9TUElfV0lEVEggfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIFNDVV9IV19TVFJBUF9WR0FfU0laRV9TRVQo
VkdBXzE2TV9EUkFNKSB8ICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIFNDVV9BU1Qy
NDAwX0hXX1NUUkFQX0JPT1RfTU9ERShBU1QyNDAwX1NQSV9CT09UKSkKKworLyogUGllc3Rld2Eg
UGVhayBoYXJkd2FyZSB2YWx1ZTogICovCisjZGVmaW5lIEVMVEFOUFdQX0JNQ19IV19TVFJBUDEg
KCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIFNDVV9B
U1QyNDAwX0hXX1NUUkFQX0RSQU1fU0laRShEUkFNX1NJWkVfMjU2TUIpIHwgICAgICAgICAgICAg
ICBcCisgICAgICAgIFNDVV9BU1QyNDAwX0hXX1NUUkFQX0RSQU1fQ09ORklHKDIgLyogRERSMyB3
aXRoIENMPTYsIENXTD01ICovKSB8IFwKKyAgICAgICAgU0NVX0FTVDI0MDBfSFdfU1RSQVBfQUNQ
SV9ESVMgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0FT
VDI0MDBfSFdfU1RSQVBfU0VUX0NMS19TT1VSQ0UoQVNUMjQwMF9DTEtfNDhNX0lOKSB8ICAgICAg
IFwKKyAgICAgICAgU0NVX0hXX1NUUkFQX1ZHQV9DTEFTU19DT0RFIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0hXX1NUUkFQX0xQQ19SRVNFVF9QSU4g
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgU0NVX0hXX1NU
UkFQX01BQzFfUkdNSUkgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
ICAgICAgICAgU0NVX0hXX1NUUkFQX1NQSV9NT0RFKFNDVV9IV19TVFJBUF9TUElfTV9TX0VOKSB8
ICAgICAgICAgICAgICAgIFwKICAgICAgICAgU0NVX0FTVDI0MDBfSFdfU1RSQVBfU0VUX0NQVV9B
SEJfUkFUSU8oQVNUMjQwMF9DUFVfQUhCX1JBVElPXzJfMSkgfCBcCiAgICAgICAgIFNDVV9IV19T
VFJBUF9TUElfV0lEVEggfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
CkBAIC00MjMsNiArNDQwLDE1IEBAIHN0YXRpYyBjb25zdCBBc3BlZWRCb2FyZENvbmZpZyBhc3Bl
ZWRfYm9hcmRzW10gPSB7CiAgICAgICAgIC5udW1fY3MgICAgPSAxLAogICAgICAgICAuaTJjX2lu
aXQgID0gcGFsbWV0dG9fYm1jX2kyY19pbml0LAogICAgIH0sIHsKKyAgICAgICAgLm5hbWUgICAg
ICA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJlbHRhbnB3cC1ibWMiKSwKKyAgICAgICAgLmRlc2MgICAg
ICA9ICJFbHRhbiBQaWVzdGV3YSBQZWFrIEJNQyAoQVJNOTI2RUotUykiLAorICAgICAgICAuc29j
X25hbWUgID0gImFzdDI0MDAtYTEiLAorICAgICAgICAuaHdfc3RyYXAxID0gRUxUQU5QV1BfQk1D
X0hXX1NUUkFQMSwKKyAgICAgICAgLmZtY19tb2RlbCA9ICJuMjVxMjU2YSIsCisgICAgICAgIC5z
cGlfbW9kZWwgPSAibXgyNWwyNTYzNWUiLAorICAgICAgICAubnVtX2NzICAgID0gMSwKKyAgICAg
ICAgLmkyY19pbml0ICA9IHBhbG1ldHRvX2JtY19pMmNfaW5pdCwKKyAgICB9LCB7CiAgICAgICAg
IC5uYW1lICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgiYXN0MjUwMC1ldmIiKSwKICAgICAgICAg
LmRlc2MgICAgICA9ICJBc3BlZWQgQVNUMjUwMCBFVkIgKEFSTTExNzYpIiwKICAgICAgICAgLnNv
Y19uYW1lICA9ICJhc3QyNTAwLWExIiwKZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfc29jLmMg
Yi9ody9hcm0vYXNwZWVkX3NvYy5jCm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKaW5k
ZXggMGY2ZTViZS4uOGVkNzkwMgotLS0gYS9ody9hcm0vYXNwZWVkX3NvYy5jCisrKyBiL2h3L2Fy
bS9hc3BlZWRfc29jLmMKQEAgLTE4NCw5ICsxODQsMTMgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3Nv
Y19pbml0KE9iamVjdCAqb2JqKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgT0JKRUNUKCZzLT5zY3UpLCAmZXJyb3JfYWJvcnQpOwogICAgIH0KIAotICAgIG9iamVjdF9p
bml0aWFsaXplKCZzLT5mdGdtYWMxMDAsIHNpemVvZihzLT5mdGdtYWMxMDApLCBUWVBFX0ZUR01B
QzEwMCk7Ci0gICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChvYmosICJmdGdtYWMxMDAiLCBP
QkpFQ1QoJnMtPmZ0Z21hYzEwMCksIE5VTEwpOwotICAgIHFkZXZfc2V0X3BhcmVudF9idXMoREVW
SUNFKCZzLT5mdGdtYWMxMDApLCBzeXNidXNfZ2V0X2RlZmF1bHQoKSk7CisgICAgb2JqZWN0X2lu
aXRpYWxpemUoJnMtPmZ0Z21hYzEwMFswXSwgc2l6ZW9mKHMtPmZ0Z21hYzEwMCksIFRZUEVfRlRH
TUFDMTAwKTsKKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKG9iaiwgImZ0Z21hYzEwMFsw
XSIsIE9CSkVDVCgmcy0+ZnRnbWFjMTAwWzBdKSwgTlVMTCk7CisgICAgcWRldl9zZXRfcGFyZW50
X2J1cyhERVZJQ0UoJnMtPmZ0Z21hYzEwMFswXSksIHN5c2J1c19nZXRfZGVmYXVsdCgpKTsKKwor
ICAgIG9iamVjdF9pbml0aWFsaXplKCZzLT5mdGdtYWMxMDBbMV0sIHNpemVvZihzLT5mdGdtYWMx
MDApLCBUWVBFX0ZUR01BQzEwMCk7CisgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jaGlsZChvYmos
ICJmdGdtYWMxMDBbMV0iLCBPQkpFQ1QoJnMtPmZ0Z21hYzEwMFsxXSksIE5VTEwpOworICAgIHFk
ZXZfc2V0X3BhcmVudF9idXMoREVWSUNFKCZzLT5mdGdtYWMxMDBbMV0pLCBzeXNidXNfZ2V0X2Rl
ZmF1bHQoKSk7CiAKICAgICBvYmplY3RfaW5pdGlhbGl6ZSgmcy0+aWJ0LCBzaXplb2Yocy0+aWJ0
KSwgVFlQRV9BU1BFRURfSUJUKTsKICAgICBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKG9iaiwg
ImJ0IiwgT0JKRUNUKCZzLT5pYnQpLCBOVUxMKTsKQEAgLTM4NCwxOSArMzg4LDM5IEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF9zb2NfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
CiAgICAgICAgICAgICAgICAgICAgICAgICBBU1BFRURfU09DX1dEVF9CQVNFICsgaSAqIDB4MjAp
OwogICAgIH0KIAotICAgIC8qIE5ldCAqLwotICAgIHFkZXZfc2V0X25pY19wcm9wZXJ0aWVzKERF
VklDRSgmcy0+ZnRnbWFjMTAwKSwgJm5kX3RhYmxlWzBdKTsKLSAgICBvYmplY3RfcHJvcGVydHlf
c2V0X2Jvb2woT0JKRUNUKCZzLT5mdGdtYWMxMDApLCB0cnVlLCAiYXNwZWVkIiwgJmVycik7Ci0g
ICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmcy0+ZnRnbWFjMTAwKSwgdHJ1ZSwg
InJlYWxpemVkIiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmxvY2FsX2Vycik7Ci0g
ICAgZXJyb3JfcHJvcGFnYXRlKCZlcnIsIGxvY2FsX2Vycik7Ci0gICAgaWYgKGVycikgewotICAg
ICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsKLSAgICAgICAgcmV0dXJuOworICAgIC8q
IE5ldCBMQU4gMCovCisgICAgICAgIHFkZXZfc2V0X25pY19wcm9wZXJ0aWVzKERFVklDRSgmcy0+
ZnRnbWFjMTAwWzBdKSwgJm5kX3RhYmxlWzBdKTsKKyAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3Nl
dF9ib29sKE9CSkVDVCgmcy0+ZnRnbWFjMTAwWzBdKSwgdHJ1ZSwgImFzcGVlZCIsICZlcnIpOwor
ICAgIGlmIChzLT5zY3UuaHdfc3RyYXAxICYgU0NVX0hXX1NUUkFQX01BQzBfUkdNSUkpIHsKKyAg
ICAgICAgcWVtdV9sb2coIiVzOiBMQU4wIGVuYWJsZWRcbiIsIF9fZnVuY19fKTsKKyAgICAgICAg
b2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmcy0+ZnRnbWFjMTAwWzBdKSwgdHJ1ZSwg
InJlYWxpemVkIiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmxvY2FsX2Vycik7
CisgICAgICAgIGVycm9yX3Byb3BhZ2F0ZSgmZXJyLCBsb2NhbF9lcnIpOworICAgICAgICBpZiAo
ZXJyKSB7CisgICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsKKyAgICAgICAg
ICAgIHJldHVybjsKKyAgICAgICAgfQorICAgICAgICBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19E
RVZJQ0UoJnMtPmZ0Z21hYzEwMFswXSksIDAsIEFTUEVFRF9TT0NfRVRIMV9CQVNFKTsKKyAgICAg
ICAgc3lzYnVzX2Nvbm5lY3RfaXJxKFNZU19CVVNfREVWSUNFKCZzLT5mdGdtYWMxMDBbMF0pLCAw
LAorICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJnMtPnZp
YyksIDIpKTsKKyAgICB9CisKKyAgICAvKiBOZXQgTEFOIDEqLworICAgICAgICBxZGV2X3NldF9u
aWNfcHJvcGVydGllcyhERVZJQ0UoJnMtPmZ0Z21hYzEwMFsxXSksICZuZF90YWJsZVsxXSk7Cisg
ICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMtPmZ0Z21hYzEwMFsxXSks
IHRydWUsICJhc3BlZWQiLCAmZXJyKTsKKyAgICBpZiAocy0+c2N1Lmh3X3N0cmFwMSAmIFNDVV9I
V19TVFJBUF9NQUMxX1JHTUlJKSB7CisgICAgICAgIHFlbXVfbG9nKCIlczogTEFOMSBlbmFibGVk
XG4iLCBfX2Z1bmNfXyk7CisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1Qo
JnMtPmZ0Z21hYzEwMFsxXSksIHRydWUsICJyZWFsaXplZCIsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZsb2NhbF9lcnIpOworICAgICAgICBlcnJvcl9wcm9wYWdhdGUoJmVyciwg
bG9jYWxfZXJyKTsKKyAgICAgICAgaWYgKGVycikgeworICAgICAgICAgICAgZXJyb3JfcHJvcGFn
YXRlKGVycnAsIGVycik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICAgICAg
c3lzYnVzX21taW9fbWFwKFNZU19CVVNfREVWSUNFKCZzLT5mdGdtYWMxMDBbMV0pLCAwLCBBU1BF
RURfU09DX0VUSDJfQkFTRSk7CisgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RF
VklDRSgmcy0+ZnRnbWFjMTAwWzFdKSwgMCwKKyAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZf
Z2V0X2dwaW9faW4oREVWSUNFKCZzLT52aWMpLCAzKSk7CiAgICAgfQotICAgIHN5c2J1c19tbWlv
X21hcChTWVNfQlVTX0RFVklDRSgmcy0+ZnRnbWFjMTAwKSwgMCwgQVNQRUVEX1NPQ19FVEgxX0JB
U0UpOwotICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRSgmcy0+ZnRnbWFjMTAw
KSwgMCwKLSAgICAgICAgICAgICAgICAgICAgICAgcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJnMt
PnZpYyksIDIpKTsKIAogICAgIC8qIGlCVCAqLwogICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9v
bChPQkpFQ1QoJnMtPmlidCksIHRydWUsICJyZWFsaXplZCIsICZlcnIpOwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5o
Cm9sZCBtb2RlIDEwMDY0NApuZXcgbW9kZSAxMDA3NTUKaW5kZXggNjIzMjIzZC4uMDc5OWQ2MQot
LS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgKKysrIGIvaW5jbHVkZS9ody9hcm0vYXNw
ZWVkX3NvYy5oCkBAIC00Nyw3ICs0Nyw3IEBAIHR5cGVkZWYgc3RydWN0IEFzcGVlZFNvQ1N0YXRl
IHsKICAgICBBc3BlZWRTTUNTdGF0ZSBzcGlbQVNQRUVEX1NQSVNfTlVNXTsKICAgICBBc3BlZWRT
RE1DU3RhdGUgc2RtYzsKICAgICBBc3BlZWRXRFRTdGF0ZSB3ZHRbQVNQRUVEX1dEVFNfTlVNXTsK
LSAgICBGVEdNQUMxMDBTdGF0ZSBmdGdtYWMxMDA7CisgICAgRlRHTUFDMTAwU3RhdGUgZnRnbWFj
MTAwWzJdOwogICAgIEFzcGVlZElCVFN0YXRlIGlidDsKICAgICBBc3BlZWRHUElPU3RhdGUgZ3Bp
bzsKICAgICBBc3BlZWRQV01TdGF0ZSBwd207Ci0tIAoyLjcuNAoK

--_002_108c97d2eee749da8f75c69f06e25072Eltsrv03Eltanlocal_--

