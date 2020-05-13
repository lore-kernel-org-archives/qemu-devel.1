Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30AE205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="krjcUwF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30AE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYwrl-0002mu-3M
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYwoZ-0001J4-Fv; Wed, 13 May 2020 15:13:12 -0400
Received: from mout.web.de ([212.227.15.14]:37171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYwoW-0005YS-UR; Wed, 13 May 2020 15:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589397179;
 bh=fSgG6kYu1WMbCBkF4n1pv8Gml77l+UD5mGSVMr4Z0Tk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=krjcUwF5JqvDzphjlZGGtmUDu8BO56Sa9XWGCJyXsZLirzbR1IipuOJ1CMPQOhv+6
 +KfRGBzKCZVExDEtROJ/jxUqTUFfLnpT/C4zwE0d+HoGBCYF1CQ8dKU5pTRTSOCg8o
 168Kc4sW3MjMOSodA6lPK7lCbyRMg/wBXYAZSc4M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.82]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtgyp-1jEwgW2hHL-00v3il; Wed, 13
 May 2020 21:12:59 +0200
Date: Wed, 13 May 2020 21:12:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200513211235.4d0711d1@luklap>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yzFI692/.pAqC6+ZHkIyctK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:t7BjrOxlr3RBoOxtChXjEDMonbyEWa9us+iS3YlKrrfv6y61aY7
 vkB44fKu2DAhsAjZ4LLn2qwBwxzJhrpYo5yxakK2Ya1lz7MouJCGrCwLqjOOxrHaFgSr97e
 vTDK1cZcAGnEo6AQRezkR+/fNbqFHrPlkWeX6tqSLBpwi7HpqynbCX9YJVmi758cpmum8Nt
 9BXMPDJWp2QbyEx361z5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dIF45xD/eoA=:kxQDpoFRHMzNWX1dP1YbGa
 bDPE+r/qwl3CtyKlc9km2HXOowheb8dlc3GPKDZRIeeFCz8OjDX1cEmhsLcPPauYUWEVOpukM
 E1acUltHwD+7lBFRTsUAm/ISglOnVXlkdun285ycUkf/lAVbc7+9N5FneAIH7Ob6u9fKJtvtA
 h0FsOoU4UFaO6TPM7CVTHk4wrXqwPTFpDRN+bpZ9tJbiQ8jBxLMt8bPzzxfyhSH4jMwbZfRLA
 V/vBzjfqik35Tn40t1g2aGVuFrZvQXP27p1dnKM+2zjI3q4H5iIHtD6u11NJdEby/fIP+gpLF
 GhXn2M4OneJtXxeyVFnM16ppnbwIWH6ct7ag3I/TOoCr1cZ3ZIP0UNVXi1uheNDeZKNkJFf4S
 toRZ1OYXKJ5rBGKl7YLmsdcly8PFCp9/Hq43sla6QKS/KaubtiigbBpNThQ7bQeuilHaxM3hQ
 RQBv2RseIibuoFdOXvIhEn1JnMoxMHKQIdZpD1mLatkVrgoedBH9qfGdOpvv73WwDQ8i3ndcc
 oPzMSg7EaV0B8ZMC7aa010IY1ojMhLnV1KOO6L9dFyULoKvxbO/W4mdV3iVN/5s9s+PqHqSv1
 cRNOKofPdRyWY0VmOB5FG+P+ddGU54pTpoCTVPBzvd78Ogtn85mAAxM7oTyhUY/xHpFLO74sI
 x98t2dHNBl51wKkJr8RJl9xtiUQR3rtsn/wLgWywnMV1eiZxigSHBSQzhOAA2+X0NXZcgzMU4
 3MVQFDig+3HJP2bdwNHk+ei52AJ+4zgGutWxb+8W3SdBleXOST8q950swIYwl7QloSXZEp06k
 Ej1YNGJ5C7t38z6BOn4rwpSDX3a0pknCton4aJHq+YS19K/tBwvHl4ozPoLPcS8s+S5LTfwIR
 9hPz6QWjx5jJ+14u76K0CpuF8Af008jese2MbkLDPAh1BYEigxd0klLOM5hlRTvsbGfaiHjoK
 ptKIp3mrLyxprdNhIxA2UC6U11VMCH96I0Hp4ErM5bHqDTSELyWOTYUXor5A5Jm5DwVN4hbb5
 otwENi2rqsEkcLyDVnNoZM8BVVIz1ESyy7POukzUlDcX2VOC1dwoxjzYQL7QQk1D+j7oqR7CY
 1SdOyNw2Y04r24aFocsmZ16r+nVnRFwm2Rjv7P+g3PFzofoHDuTyrdscnWocnc/azyTO2U0RT
 qgd1jt2Xpy5Wi63QIHESPkvrt7S7FuCb3C7Ed26pqt8o8zrneJ1a96FcinsLae/IPmNTHd5Zc
 LBLJ1fbnw5Ri6FG7j
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 13:22:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/yzFI692/.pAqC6+ZHkIyctK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Terminology:
instance =3D one (nbd) blockdev/one chardev/the single migrationstate
connection =3D one TCP connection

Hello Everyone,
Having read all the comments, here is proposal v2:
Every instance registers itself with a unique name in the form "blockdev:<n=
ode-name>", "chardev:<chardev-name>" and "migration" using yank_register_in=
stance which will do some sanity checks like checking if the same name exis=
ts already. Then (multiple) yank functions can be registered as needed with=
 that single name. When the instance exits/is removed, it unregisters all y=
ank functions and unregisters it's name with yank_unregister_instance which=
 will check if all yank functions where unregistered.
Every instance that supports the yank feature will register itself and the =
yank functions unconditionally (No extra 'yank' option per instance).
The 'query-yank' oob qmp command lists the names of all registered instance=
s.
The 'yank' oob qmp command takes a list of names and for every name calls a=
ll yank functions registered with that name. Before doing anything, it will=
 check that all names exist.

If the instance has multiple connections (say, migration with multifd), i d=
on't think it makes much sense to just shutdown one connection. Calling 'ya=
nk' on a instance will always shutdown all connections of that instance.

Yank functions are generic and in no way limited to connections. Say, if mi=
gration is started to an 'exec:' address, migration could register a yank f=
unction to kill that external command on yank (Won't be implemented yet tho=
ugh).

Regards,
Lukas Straub

--Sig_/yzFI692/.pAqC6+ZHkIyctK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl68RqMACgkQNasLKJxd
sliQjg//X2izWWqcOoFytyOBCqaQTur0qxwzWWNA9tdKDSI2DB/lJQsdEygAE5yu
82UU8oWBrYM6Lq1ZjuI3LtRa6sTu3kOKXXtC94t99ZjEJZLo8Us/Mb8YnIbkHX12
lOX7GNAfUWHdUK9GVJeFVD+so0z2KGdQPKVyUrmDkeibCWKBayntrlIjjmSpFI5p
6LoIsYLkBkuupmGZOcnsz+X0KwhEQ+JbJ5D5X7UjuWWR5LgAMun1SZkR8Pp80w4J
Y1CL4VwZoqLpuSXZsWi9Ry8yk+B9r3NonIfDKRbcvbz0+YRyaUd3H6DdESVIHHQE
NRPe+IvHxU+BqtPOuZEd8nyBNmuPgJLpuZp1H5P4drTTw9xQ6FH9U8LHN0ji+q/r
ZeQKYV/oD+TuHEuN/er9IEF7t62loVofwnFEKNtIFjlM02d4+GUqdFiVVZMvQa3C
xBMFYjpnKQo9P7PLAkdcCRQkDXyqivGSTMuBOm3NXRZ8EFCZSiAmeX9ZKXUWgLSn
6NHvrDy62pd5wurardjyONA0tkKT0YvIA7zxOT8Tluf3jDRkLv9K0ixsIINECFpB
kPir9pZw7CZZvOeGZ0g/DpPbk0JEnbjyaUgw/SMC+c/NJAd5XrgOCh36fqZOS46M
blMZnDfd4VJReafGQEsxK1ocba56i2++iPt2Rav0f43vjmd50iU=
=Ob2T
-----END PGP SIGNATURE-----

--Sig_/yzFI692/.pAqC6+ZHkIyctK--

