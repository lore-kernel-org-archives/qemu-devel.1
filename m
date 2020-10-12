Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A45206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIyHrhSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A45206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4Aq-00039F-OJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cosmin.chenaru@gmail.com>)
 id 1kS3P8-0007uB-Hj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 15:22:42 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c]:43111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cosmin.chenaru@gmail.com>)
 id 1kS3P6-0002Cr-1d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 15:22:42 -0400
Received: by mail-il1-x12c.google.com with SMTP id d16so12641iln.10
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XUTISeZ55Fd+G0CYX5P0d1M1JI/cb/fqpfH6kPFuGFA=;
 b=VIyHrhSutpO12T6YW5bhX60OyAhcd4Cj0sVa4AqZKsyii/j/iY5uj5akere01Ev/x5
 erCn7jbTUAk5qNPJO5iy5qcanA8EnZbrn84mgD8YT6n72CV+mi//esPaWA6YJj6VFB0b
 XhZhwgOxi6ALv7KpSrsnkBLJ8g/dbEhmoSlam6uX7BXN/edHlyaVHXOuChoeWvV8kxqK
 gApNaUHbm3nvDiEICXIcayEKE7lx53zuBXiO91feSGUWg7c1J9YA/FSg3Ws38xcMdRkK
 Wq31TWYyKIWseyGjgwxDEW3iAqw8nP5Cisv/6nvxEzFoP8+uOZh+21zxJX6F1X0KJQ8D
 KiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XUTISeZ55Fd+G0CYX5P0d1M1JI/cb/fqpfH6kPFuGFA=;
 b=BGUPReqKzVBpFluz1ra8Ls78DqP97LJCHQL9BEXrB1tgdkhelKY2FiXOhzq5PUrIIq
 lY3AktyMAPCtL2dfDlRQOklG6Fb0CCLM0cKOBIKeOMrRpEBTXphcOOQlLh4E9Jcf6mAh
 8vzVxmGjKMbekq24qyepkOA1pFURjp3LsfQBqB8CDO+Q0xCpij1SRmWV1NzJepTatDCJ
 KgvtkNvT53rPqT/hSyrlxOzSVtep+u2FO0zd5MYzuVhh1H5cGMmVdjYi9CjgWU0vpPEg
 pPfpvr9bkWgh+9fJipwubWDcNA/l5foPYLbznPqV7PM6I6i2lwOC6opGJuu+TPu330TQ
 bqPQ==
X-Gm-Message-State: AOAM530vVJ9aGOFIsEwaf9c4a/Es6vJl7JIytE0wYw6df9jiaSTGLCcY
 BYt86nit4LHUX2bda/N/Lsrmro9WCcuBNYtWVXwXUMO21Ko=
X-Google-Smtp-Source: ABdhPJzDFzl5/g9jeGfFA05Yyy2bNa7sdqvMp+99Ubui6iaCFB+t3b9+JllQCLYAwoVNt79JmhBdKtF9BzIhXDun4ZA=
X-Received: by 2002:a92:da8e:: with SMTP id u14mr276847iln.235.1602530557924; 
 Mon, 12 Oct 2020 12:22:37 -0700 (PDT)
MIME-Version: 1.0
From: Cosmin Chenaru <cosmin.chenaru@gmail.com>
Date: Mon, 12 Oct 2020 22:22:27 +0300
Message-ID: <CADx_CBPzAstC0o9X6CrnyFqYYAtPbw5-XHWxmXTt6+LyYb-U3g@mail.gmail.com>
Subject: Using virtio-vhost-user or vhost-pci
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a59b8d05b17e3878"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=cosmin.chenaru@gmail.com; helo=mail-il1-x12c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 16:11:23 -0400
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

--000000000000a59b8d05b17e3878
Content-Type: text/plain; charset="UTF-8"

Hi,

Could you please tell me if there has been any more work on
virtio-vhost-user or vhost-pci? The last messages that I could find were
from January 2018, from this thread [1], and from what I see the latest
Qemu code does not have that included.

I am currently running multiple VMs, connected in between by the DPDK
vhost-switch. A VM can start, reboot, shutdown, so much of this is dynamic
and the vhost-switch handles all of these. So these VMs are some sort of
"endpoints" (I could not find a better naming).

The code which runs on the VM endpoints is somehow tied to the vhost-switch
code, and if I change something on the VM which breaks the compatibility, I
need to recompile the vhost-switch and restart. The problem is that most of
the time I forget to update the vhost-switch, and I run into other problems.

If I could use a VM as a vhost-switch instead of the DPDK app, then I hope
that in my endpoint code which runs on the VM, I can add functionality to
make it also run as a switch, and forward the packets between the other VMs
like the current DPDK switch does. Doing so would allow me to catch this
out-of-sync between the VM endpoint code and the switch code at compile
time, since they will be part of the same app.

This would be a two-phase process. First to run the DPDK vhost-switch
inside a guest VM, and then to move the tx-rx part into my app.

Both Qemu and the DPDK app use "vhost-user". I was happy to see that I can
start Qemu in vhost-user server mode:

    <interface type='vhostuser'>
      <mac address='52:54:00:9c:3a:e3'/>
      <source type='unix' path='/home/cosmin/vsocket.server' mode='server'/>
      <model type='virtio'/>
      <driver queues='2'>
        <host mrg_rxbuf='on'/>
      </driver>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </interface>

This would translate to these Qemu arguments:

-chardev socket,id=charnet1,path=/home/cosmin/vsocket.server,server -netdev
type=vhost-user,id=hostnet1,chardev=charnet1,queues=2 -device
virtio-net-pci,mrg_rxbuf=on,mq=on,vectors=6,netdev=hostnet1,id=net1,mac=52:54:00:9c:3a:e3,bus=pci.0,addr=0x4

But at this point Qemu will not boot the VM until there is a vhost-user
client connecting to Qemu. I even tried adding the "nowait" argument, but
Qemu still waits. This will not work in my case, as the endpoint VMs could
start and stop at any time, and I don't even know how many network
interfaces the endpoint VMs will have.

I then found the virtio-vhost-user transport protocol [2], and was thinking
that I could at least start the packet-switching VM, and then let the DPDK
app inside it do the forwarding of the packets. But from what I understand,
this creates a single network interface inside the VM on which the DPDK app
can bind. The limitation here is that if another VM wants to connect to the
packet-switching VM, I need to manually add another virtio-vhost-user-pci
device (and a new vhost-user.sock) before this packet-switching VM starts,
so this is not dynamic.

The second approach for me would be to use vhost-pci [3], which I could not
fully understand how it works, but I think it presents a network interface
to the guest kernel after another VM connects to the first one.

I realize I made a big story and probably don't make too much sense, but
one more thing. The ideal solution for me would be a combination of the
vhost-user socket and the vhost-pci socket. The Qemu will start the VM and
the socket will wait in the background for vhost-user connections. When a
new connection is established, Qemu should create a hot-plugable PCI
network card and either the guest kernel or the DPDK app inside to handle
the vhost-user messages.

Any feedback will be welcome, and I really appreciate all your work :)

Cosmin.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04806.html
[2] https://wiki.qemu.org/Features/VirtioVhostUser
[3] https://github.com/wei-w-wang/vhost-pci

--000000000000a59b8d05b17e3878
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Could you please tell me if there h=
as been any more work on virtio-vhost-user or vhost-pci? The last messages =
that I could find were from January 2018, from this thread [1], and from wh=
at I see the latest Qemu code does not have that included.</div><div><br></=
div><div>I am currently running multiple VMs, connected in between by the D=
PDK vhost-switch. A VM can start, reboot, shutdown, so much of this is dyna=
mic and the vhost-switch handles all of these. So these VMs are some sort o=
f &quot;endpoints&quot; (I could not find a better naming).</div><div><br><=
/div><div>The code which runs on the VM endpoints is somehow tied to the vh=
ost-switch code, and if I change something on the VM which breaks the compa=
tibility, I need to recompile the vhost-switch and restart. The problem is =
that most of the time I forget to update the vhost-switch, and I run into o=
ther problems.</div><div><br></div><div>If I could use a VM as a vhost-swit=
ch instead of the DPDK app, then I hope that in my endpoint code which runs=
 on the VM, I can add functionality to make it also run as a switch, and fo=
rward the packets between the other VMs like the current DPDK switch does. =
Doing so would allow me to catch this out-of-sync between the VM endpoint c=
ode and the switch code at compile time, since they will be part of the sam=
e app.</div><div><br></div><div>This would be a two-phase process. First to=
 run the DPDK vhost-switch inside a guest VM, and then to move the tx-rx pa=
rt into my app.</div><div><br></div><div>Both Qemu and the DPDK app use &qu=
ot;vhost-user&quot;. I was happy to see that I can start Qemu in vhost-user=
 server mode:</div><div><br></div><div>=C2=A0 =C2=A0 &lt;interface type=3D&=
#39;vhostuser&#39;&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;mac address=3D&#39;52:54=
:00:9c:3a:e3&#39;/&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;source type=3D&#39;unix&=
#39; path=3D&#39;/home/cosmin/vsocket.server&#39; mode=3D&#39;server&#39;/&=
gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;model type=3D&#39;virtio&#39;/&gt;<br>=C2=
=A0 =C2=A0 =C2=A0 &lt;driver queues=3D&#39;2&#39;&gt;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &lt;host mrg_rxbuf=3D&#39;on&#39;/&gt;<br>=C2=A0 =C2=A0 =C2=A0 &=
lt;/driver&gt;<br>=C2=A0 =C2=A0 =C2=A0 &lt;address type=3D&#39;pci&#39; dom=
ain=3D&#39;0x0000&#39; bus=3D&#39;0x00&#39; slot=3D&#39;0x04&#39; function=
=3D&#39;0x0&#39;/&gt;<br>=C2=A0 =C2=A0 &lt;/interface&gt;<br></div><div><br=
></div><div>This would translate to these Qemu arguments:</div><div><br></d=
iv><div>-chardev socket,id=3Dcharnet1,path=3D/home/cosmin/vsocket.server,se=
rver -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1,queues=3D2 =
-device virtio-net-pci,mrg_rxbuf=3Don,mq=3Don,vectors=3D6,netdev=3Dhostnet1=
,id=3Dnet1,mac=3D52:54:00:9c:3a:e3,bus=3Dpci.0,addr=3D0x4<br></div><div><br=
></div><div>But at this point Qemu will not boot the VM until there is a vh=
ost-user client connecting to Qemu. I even tried adding the &quot;nowait&qu=
ot; argument, but Qemu still waits. This will not work in my case, as the e=
ndpoint VMs could start and stop at any time, and I don&#39;t even know how=
 many network interfaces the endpoint VMs will have.</div><div><br></div><d=
iv>I then found the virtio-vhost-user transport protocol [2], and was=C2=A0=
thinking that I could at least start the packet-switching VM, and then let =
the DPDK app inside it do the forwarding of the packets. But from what I un=
derstand, this creates a single network interface inside the VM on which th=
e DPDK app can bind. The limitation here is that if another VM wants to con=
nect to the packet-switching VM, I need to manually add another virtio-vhos=
t-user-pci device (and a new vhost-user.sock) before this packet-switching =
VM starts, so this is not dynamic.=C2=A0 =C2=A0</div><div><br></div><div>Th=
e second approach for me would be to use vhost-pci [3], which I could not f=
ully understand how it=C2=A0works, but I think it presents a network interf=
ace to the guest kernel after another VM connects to the first one.</div><d=
iv><br></div><div>I realize I made a big story and probably don&#39;t make =
too much sense, but one more thing. The ideal solution for me would be a co=
mbination of the vhost-user socket and the vhost-pci socket. The Qemu will =
start the VM and the socket will wait in the background for vhost-user conn=
ections. When a new connection is established, Qemu should create a hot-plu=
gable PCI network card and either the guest kernel or the DPDK app inside t=
o handle the vhost-user messages.</div><div><br></div><div>Any feedback wil=
l be welcome, and I really appreciate all your work :)</div><div><br></div>=
<div>Cosmin.</div><div><br></div><div>[1] <a href=3D"https://lists.nongnu.o=
rg/archive/html/qemu-devel/2018-01/msg04806.html">https://lists.nongnu.org/=
archive/html/qemu-devel/2018-01/msg04806.html</a><br></div><div>[2]=C2=A0<a=
 href=3D"https://wiki.qemu.org/Features/VirtioVhostUser">https://wiki.qemu.=
org/Features/VirtioVhostUser</a></div><div>[3]=C2=A0<a href=3D"https://gith=
ub.com/wei-w-wang/vhost-pci">https://github.com/wei-w-wang/vhost-pci</a></d=
iv><div><br></div></div>

--000000000000a59b8d05b17e3878--

