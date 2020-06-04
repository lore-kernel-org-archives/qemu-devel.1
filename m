Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424E4206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424E4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglek-0008Ba-ER
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgle1-0007fl-Hi
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgldz-0002B8-Va
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:54:37 -0400
Received: from mail-vk1-f197.google.com ([209.85.221.197])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jgldw-0008Lp-WF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:54:33 +0000
Received: by mail-vk1-f197.google.com with SMTP id s206so1361994vke.20
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 01:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=LlKt0iABwFApk3o8kenBWL6rdHReoMcLtx536GsSyV4=;
 b=Lh9j/2g/LKYUMuo5/P8NWrtRCLbXh2/ofOaXESgxSaGktn58p33+wcQBkdk2q/Ota9
 4HX2jYEUaNMzjERxeUErHE6Nt+xkNHy7lqwKx5S7QqafGSmoxhvXda7zwFt5nZa66jvc
 n09nITaGXYdIHp+7y/FyjQ0sb+IWmFld4mAVk0MBWNWVr3Mex9YNNSgmy9EE6M5b43xN
 x3dJ4/IFRY4LnWpdxwNDyk8yVlxnR0XW4ovHgMGZwifngF15MGT02Q+XRqexcMhDHDG9
 bvO8jpbm2G9j5M+UUX2tKLnlJy9YV16He8YVPMQ8tBv8Hf8ha4ckhbMeLhPy6hxGzxWo
 87lA==
X-Gm-Message-State: AOAM532Ldr93Njr5BtQaMEweVr1cVL8bmSneCviDOPso2wFcnHFQRmX3
 Dh9ByQs23fdnuD/9Kj9FS5+reBs8fhiFhPZIp2fcCocAy49Qzl2BBOe0E+KkudU0ivK4xKSHoe+
 nvhGF3y6Vv2H5fMP+VniUKjUzUQo3VVAE4ERKzCypA2uV0hVe
X-Received: by 2002:a67:c806:: with SMTP id u6mr2459537vsk.94.1591260872037;
 Thu, 04 Jun 2020 01:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFZb0zIAgpssTGaK8S7bLCU1NbZuIGvD6H83HuANdH2KBcxg54jVXSkrs46Iwv2MDeDyduFg71lvGwicdWhOw=
X-Received: by 2002:a67:c806:: with SMTP id u6mr2459531vsk.94.1591260871783;
 Thu, 04 Jun 2020 01:54:31 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 4 Jun 2020 10:54:04 +0200
Message-ID: <CAATJJ0+p2U8uf+Vq_sn=1agSYbZ1iQu_+La8QLCVhMVkK-SKtA@mail.gmail.com>
Subject: qemu-guest agent asserts on shutdown
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000020d7805a73e4b89"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 04:54:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000020d7805a73e4b89
Content-Type: text/plain; charset="UTF-8"

Hi,
while debugging a report I got in Ubuntu I found that since qemu 4.0 the
guest agent shutdown feature works (guest is shutting down) but crashes
when doing so each time. This can be a big red herring when debugging other
things as well as people start to get "an application crashed, do you want
to report" pop-ups if they have set up automatic crash reports.

If you boot the guest after starting it again and check the guest-agent
status you will see in journal:
-- Logs begin at Tue 2020-06-02 07:41:32 UTC, end at Thu 2020-06-04
08:07:37 UTC. --
Jun 02 07:47:58 focal systemd[1]: Started QEMU Guest Agent.
Jun 02 07:49:03 focal qemu-ga[1984]: info: guest-shutdown called, mode:
(null)
Jun 02 07:49:03 focal qemu-ga[1984]: **
Jun 02 07:49:03 focal qemu-ga[1984]:
ERROR:/build/qemu-7aKH5L/qemu-4.2/qga/main.c:532:send_response: assertion
failed: (rsp && s->channel)
Jun 02 07:49:03 focal qemu-ga[1984]: Bail out!
ERROR:/build/qemu-7aKH5L/qemu-4.2/qga/main.c:532:send_response: assertion
failed: (rsp && s->channel)
Jun 02 07:49:04 focal systemd[1]: Stopping QEMU Guest Agent...
Jun 02 07:49:04 focal systemd[1]: qemu-guest-agent.service: Succeeded.
Jun 02 07:49:04 focal systemd[1]: Stopped QEMU Guest Agent.

The actual assert is from "forever" [3] (v0.15) which is the initial
addition of qemu guest agent in 2011. That was later restructured in [1]
(v1.1) and [2] (v4.0).

In a check through Ubuntu releases I got
1) Host: Q 2.11 L 4.0 (Bionic) - G 2.11 (Bionic)
2) Host: Q 4.0 L 5.4 (Eoan) - G 2.11 (Bionic)
3) Host: Q 4.2 L 6.0 (Focal) - G 2.11 (Bionic)
4) Host: Q 2.11 L 4.0 (Bionic) - G 4.0 (Eoan)
5) Host: Q 4.0 L 5.4 (Eoan) - G 4.0 (Eoan)
6) Host: Q 4.2 L 6.0 (Focal) - G 4.0 (Eoan)
7) Host: Q 2.11 L 4.0 (Bionic) - G 4.2 (Focal)
8) Host: Q 4.0 L 5.4 (Eoan) - G 4.2 (Focal)
9) Host: Q 4.2 L 6.0 (Focal) - G 4.2 (Focal)

So it seemed to be the qemu-guest-agent portion since >=4.0.
I did a build with [2] reverted and the crash is gone.

I see from the host:
$ virsh qemu-agent-command focal '{"execute": "guest-shutdown"}'
"error: Guest agent is not responding: Guest agent disappeared while
executing command"

I'm not sure which part of the communication breaks first, but it could try
to send on a dying connection, the old code had:

rsp = qmp_dispatch(&ga_commands, QOBJECT(req), false);
    if (rsp) {
        ret = send_response(s, rsp)

While the new code is like:

    rsp = qmp_dispatch(&ga_commands, obj, false);
end:
     ret = send_response(s, rsp);

Maybe it runs send_response despite qmp_dispatch failing now?

I didn't stare at it long enough to have a solution yet, but wanted to make
the maintainer of qga and the Author aware.

[1]: https://git.qemu.org/?p=qemu.git;a=commit;h=125b310e1d62
[2]: https://git.qemu.org/?p=qemu.git;a=commit;h=781f2b3d1e5e
[3]: https://git.qemu.org/?p=qemu.git;a=commit;h=48ff7a625b36

-- 
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--000000000000020d7805a73e4b89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>while debugging=C2=A0a report I got in =
Ubuntu I found that since qemu 4.0 the guest agent shutdown feature works (=
guest is shutting down) but crashes when doing so each time. This can be a =
big red herring when debugging other things as well as people start to get =
&quot;an application crashed, do you want to report&quot; pop-ups if they h=
ave set up automatic crash reports.</div><div><br></div><div>If you boot th=
e guest after starting it again and check the guest-agent status you will s=
ee in journal:</div><div>-- Logs begin at Tue 2020-06-02 07:41:32 UTC, end =
at Thu 2020-06-04 08:07:37 UTC. --<br>Jun 02 07:47:58 focal systemd[1]: Sta=
rted QEMU Guest Agent.<br>Jun 02 07:49:03 focal qemu-ga[1984]: info: guest-=
shutdown called, mode: (null)<br>Jun 02 07:49:03 focal qemu-ga[1984]: **<br=
>Jun 02 07:49:03 focal qemu-ga[1984]: ERROR:/build/qemu-7aKH5L/qemu-4.2/qga=
/main.c:532:send_response: assertion failed: (rsp &amp;&amp; s-&gt;channel)=
<br>Jun 02 07:49:03 focal qemu-ga[1984]: Bail out! ERROR:/build/qemu-7aKH5L=
/qemu-4.2/qga/main.c:532:send_response: assertion failed: (rsp &amp;&amp; s=
-&gt;channel)<br>Jun 02 07:49:04 focal systemd[1]: Stopping QEMU Guest Agen=
t...<br>Jun 02 07:49:04 focal systemd[1]: qemu-guest-agent.service: Succeed=
ed.<br>Jun 02 07:49:04 focal systemd[1]: Stopped QEMU Guest Agent.<br></div=
><div><br></div><div>The actual assert is from &quot;forever&quot; [3] (v0.=
15) which is the initial addition of qemu guest agent in 2011. That was lat=
er restructured in [1] (v1.1) and [2] (v4.0).<br></div><div><br></div><div>=
In a check through=C2=A0Ubuntu releases I got</div><div>1) Host: Q 2.11 L 4=
.0 (Bionic) - G 2.11 (Bionic)<br>2) Host: Q 4.0 L 5.4 (Eoan) - G 2.11 (Bion=
ic)<br>3) Host: Q 4.2 L 6.0 (Focal) - G 2.11 (Bionic)<br>4) Host: Q 2.11 L =
4.0 (Bionic) - G 4.0 (Eoan)<br>5) Host: Q 4.0 L 5.4 (Eoan) - G 4.0 (Eoan)<b=
r>6) Host: Q 4.2 L 6.0 (Focal) - G 4.0 (Eoan)<br>7) Host: Q 2.11 L 4.0 (Bio=
nic) - G 4.2 (Focal)<br>8) Host: Q 4.0 L 5.4 (Eoan) - G 4.2 (Focal)<br>9) H=
ost: Q 4.2 L 6.0 (Focal) - G 4.2 (Focal)<br></div><div><br></div><div>So it=
 seemed to be the qemu-guest-agent portion since &gt;=3D4.0.</div><div>I di=
d a build with [2] reverted and the crash is gone.</div><div><br></div><div=
>I see from the host:<br>$ virsh qemu-agent-command focal &#39;{&quot;execu=
te&quot;: &quot;guest-shutdown&quot;}&#39;<br>&quot;error: Guest agent is n=
ot responding: Guest agent disappeared while executing command&quot;<br><br=
>I&#39;m not sure which part of the communication breaks first, but it coul=
d try to send on a dying connection, the old code had:<br><br>rsp =3D qmp_d=
ispatch(&amp;ga_commands, QOBJECT(req), false);<br>=C2=A0 =C2=A0 if (rsp) {=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_response(s, rsp)<br><br>While =
the new code is like:</div><div><br>=C2=A0 =C2=A0 rsp =3D qmp_dispatch(&amp=
;ga_commands, obj, false);<br>end:<br>=C2=A0 =C2=A0 =C2=A0ret =3D send_resp=
onse(s, rsp);<br><br>Maybe it runs send_response despite qmp_dispatch faili=
ng now?<br></div><div><br></div><div>I didn&#39;t stare at it long enough t=
o have a solution yet, but wanted to make the maintainer of qga and the Aut=
hor aware.<br></div><br>[1]: <a href=3D"https://git.qemu.org/?p=3Dqemu.git;=
a=3Dcommit;h=3D125b310e1d62">https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;=
h=3D125b310e1d62</a><br>[2]: <a href=3D"https://git.qemu.org/?p=3Dqemu.git;=
a=3Dcommit;h=3D781f2b3d1e5e">https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;=
h=3D781f2b3d1e5e</a><br>[3]: <a href=3D"https://git.qemu.org/?p=3Dqemu.git;=
a=3Dcommit;h=3D48ff7a625b36">https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;=
h=3D48ff7a625b36</a><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Christian Eh=
rhardt<br>Staff Engineer, Ubuntu Server<br>Canonical Ltd</div></div>

--000000000000020d7805a73e4b89--

