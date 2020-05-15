Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BADCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6142065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6142065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTyJ-0002fq-LN
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZTxX-00028s-HA; Fri, 15 May 2020 02:36:39 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:60178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZTxU-0002uE-9E; Fri, 15 May 2020 02:36:38 -0400
Received: from [88.198.139.25] (helo=[10.17.32.77])
 by mail.hetzner.company with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZTxL-0000zT-0o; Fri, 15 May 2020 08:36:27 +0200
Subject: Re: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <158946069407.13639.5714365663552293557@45ef0f9c86ae>
 <ece77427-d918-d766-b2bc-08cf7d4660bc@redhat.com>
From: Raphael Pour <raphael.pour@hetzner.com>
Autocrypt: addr=raphael.pour@hetzner.com; keydata=
 mDMEXmXjyxYJKwYBBAHaRw8BAQdAtiEYnlLIuIUjvvqOH//nEbhrxSa54ZyAl7Iel403QaW0
 J1JhcGhhZWwgUG91ciA8cmFwaGFlbC5wb3VyQGhldHpuZXIuY29tPoiWBBMWCAA+FiEEvj4O
 DnHb6pxm/uWJzbHrt4XF634FAl5l48sCGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQzbHrt4XF635TcwD+NEMqL1HZPHP/WRsYujCDtqt0p+7uxGcpvzv//AjqMZ0A+wUh
 0bOYYNdlXWNMMNLA88SsAT2mxAfD+F/paVmLpdoLuDgEXmXjyxIKKwYBBAGXVQEFAQEHQB0z
 JYP6jtTj989IJL1vguinsiIxia5fkW83OB1+Bb4QAwEIB4h+BBgWCAAmFiEEvj4ODnHb6pxm
 /uWJzbHrt4XF634FAl5l48sCGwwFCQlmAYAACgkQzbHrt4XF6372LgEAi3qfceU+R53Ehg/Y
 SSHV4wg+zfPwrD6ylEg/xKabYDcBALrD0E3YX458RPjLIOC8H0u0rcFIvBqNYx/kGaMEmbEG
Message-ID: <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
Date: Fri, 15 May 2020 08:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ece77427-d918-d766-b2bc-08cf7d4660bc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zGkHSIjRG6WNEV6icPiFNXiXUqtnV8K4n"
X-Authenticated-Sender: raphael.pour@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=raphael.pour@hetzner.com; helo=mail.hetzner.company
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zGkHSIjRG6WNEV6icPiFNXiXUqtnV8K4n
Content-Type: multipart/mixed; boundary="17xzHILRh5wACaveqi266PaI3oan2SY14"

--17xzHILRh5wACaveqi266PaI3oan2SY14
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/14/20 4:55 PM, Eric Blake wrote:
> On 5/14/20 9:29 AM, Eric Blake wrote:
>=20
>>> WARNING: Block comments use a leading /* on a separate line
>>> #20: FILE: qemu-nbd.c:919:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Remember parents stderr only if the fork option is set.
>>>
>=20
>> The comment could use some grammar help (s/parents/parent's/), and in
>> truth, I don't think it adds much beyond what the code itself is
>> already doing, so rather than adding another line to silence patchew,
>> you could instead just eliminate the comment and life would still be
>> fine.=C2=A0 Or if you want a one-line comment, I might suggest:
>>
>> /* Remember parent's stderr if we will restoring it. */
>=20
> It helps if I don't hit 'send' too early.
>=20
> /* Remember parent's stderr if we will be restoring it. */
>=20

=46rom e5749541494abcdcaa37d752172741e1bc38e984 Mon Sep 17 00:00:00 2001
From: Raphael Pour <raphael.pour@hetzner.com>
Date: Fri, 15 May 2020 08:30:50 +0200
Subject: [PATCH] qemu-nbd: Close inherited stderr

Close inherited stderr of the parent if fork_process is false.
Otherwise no one will close it. (introduced by e6df58a5)

Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
---
 qemu-nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4aa005004e..306e44fb0a 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -916,7 +916,11 @@ int main(int argc, char **argv)
         } else if (pid =3D=3D 0) {
             close(stderr_fd[0]);

-            old_stderr =3D dup(STDERR_FILENO);
+            /* Remember parent's stderr if we will be restoring it. */
+            if (fork_process) {
+                old_stderr =3D dup(STDERR_FILENO);
+            }
+
             ret =3D qemu_daemon(1, 0);

             /* Temporarily redirect stderr to the parent's pipe...  */
--=20
2.25.4


I fixed the issues and checkpatch gave me a 'ready for submission'.
Is this the right way to submit a fixed patch or should it be a v3?


--=20
Hetzner Online GmbH
Am Datacenter-Park 1
08223 Falkenstein/Vogtland
raphael.pour@hetzner.com
www.hetzner.com

Registergericht Ansbach, HRB 6089
Gesch=C3=A4ftsf=C3=BChrer: Martin Hetzner, Stephan Konvickova, G=C3=BCnth=
er M=C3=BCller


--17xzHILRh5wACaveqi266PaI3oan2SY14--

--zGkHSIjRG6WNEV6icPiFNXiXUqtnV8K4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS+Pg4OcdvqnGb+5YnNseu3hcXrfgUCXr44ZwAKCRDNseu3hcXr
fscRAQD0Cpa0HjT/Uo/FjsrNjcd7eiq/YQLVElC5tD2WeYLtHQD+N44kqvzaRreO
h0TkjgBDW6muiH9gxk2mDx+684+hAQ8=
=mglE
-----END PGP SIGNATURE-----

--zGkHSIjRG6WNEV6icPiFNXiXUqtnV8K4n--

