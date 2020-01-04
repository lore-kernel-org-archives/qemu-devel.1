Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A442C32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 06:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5477F217F4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 06:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn/a4WJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5477F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1incVL-00021t-EV
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 01:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1incUN-0001RI-3h
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 01:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1incUL-0006A9-Nr
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 01:00:43 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:46036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1incUL-00066m-E3
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 01:00:41 -0500
Received: by mail-lj1-x234.google.com with SMTP id j26so45772456ljc.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OtQIK7f3PZ05TuATV4flHg3id/du1mm7eyX5dhUnwh8=;
 b=Hn/a4WJf7yAOxhWRMB1uSgDR4onYGHGaZbU02rKQlHcCzaa9EttTDRKENbkwvJirB+
 TCi7qO3euainyiDyGi6iS6byxYDuu5jJA4pob7+VGyPJYYLkaYZFdDYD8KP8RSK8rtHC
 1O0jhcC5mhgjGaADFaDeVhBgYjV+e32p4WY3gWJgeNZ8bGeC6vtJKFXHRv5Jg5BjXzoZ
 roOTfNTo31ovG0MLwyr14X+KdbTxA4dL46hc8l9v6LjWXVu1k/m+EH+59FKepT19p3gx
 6qaYtGcP4g6oyz8WIFaBEGBZ94o5jJaEiy9q+Kwynyw9uZcgew3xfbUl7TjFGJ1fjm0b
 d7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OtQIK7f3PZ05TuATV4flHg3id/du1mm7eyX5dhUnwh8=;
 b=Tk4hqdW4lTGCIp50ha9sTYHMUq6g7p4d8krDMXw66W2M1KSvmPWu3se7AS1py446NT
 obBBY2NL6vnl2IrCmYkdllFq07vjeIWxsKAM5ufbrXuhzkW1bYrKfudmzn9KbhFrEJt2
 SAydQHez9qkyJWqXGdwVcV/K9T7jiW8fWMLkBZK6mkry11Jdg+uoODu3ocQe8AZ+0eY1
 AYM/93+oUxJWnTlogMK78bgEIO4Co+ajKC2xwhIMaLtDCnjiXhyD91j0tMSyZ51xSmHL
 twOq8urHs6W8UIsrZ8oIGnNWDu1YuKK6AEp03v1+JAeNokXMLZkTyXrWok/zlGqFuIKs
 BVIw==
X-Gm-Message-State: APjAAAVi3BuzL4A52weYLKzlihp32Q7wGBvAB+lyQANpsYGehqxIm5je
 VaMS3GGduMgpIV3hw8a/Aok8VX+uA/kFrJIxtyI=
X-Google-Smtp-Source: APXvYqzmw4L4Y1uSqWIh7q0XxG9zj9dJQZHMjVhjDsiCud5D1K+kU09NiCuOWu7wnrVNi88wWrtcswgx93CHWMYCmfM=
X-Received: by 2002:a2e:e12:: with SMTP id 18mr44140306ljo.123.1578117639195; 
 Fri, 03 Jan 2020 22:00:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJAkqrXyeVn4iy7NzkR__BS9q9xT4ZWcjJszNBaSKH0U57c4hw@mail.gmail.com>
 <20191114111429.GC580024@stefanha-x1.localdomain>
 <CAJAkqrULM=wjDEVV8kZBU4u1ag4ERiKq3z5yzRus3vqwsx_a4A@mail.gmail.com>
 <20191213105810.GD1180977@stefanha-x1.localdomain>
In-Reply-To: <20191213105810.GD1180977@stefanha-x1.localdomain>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Sat, 4 Jan 2020 14:00:02 +0800
Message-ID: <CAJAkqrVzryw3L5V0=pTEv=wfO9t7423FbySzn3_bD_LpHUqqag@mail.gmail.com>
Subject: Re: How to extend QEMU's vhost-user tests after implementing
 vhost-user-blk device backend
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004c4fc7059b4a25b6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::234
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004c4fc7059b4a25b6
Content-Type: text/plain; charset="UTF-8"

Thank you for the advice! I've skipped test cases regarding resizing the
disk. The remaining tests are "indirect" and "basic". vhost-user-blk device
has now passed the "basic" test
(/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/vhost-user-blk-pci/vhost-user-blk/vhost-user-blk-tests/basic)
as virtio-blk-deivce. But it fails the "indirect" test because
libvhost-user doesn't support VIRTIO_RING_F_INDIRECT_DESC (indirect buffer
descriptors),  Would you suggest me to improve libvhost-user to
support indirect buffer descriptors?

On Fri, Dec 13, 2019 at 6:58 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, Dec 11, 2019 at 11:25:32PM +0800, Coiby Xu wrote:
> > I'm now writing the tests for vhost-user-blk device based on
> > tests/virtio-blk-test.c. But block_resize command doesn't apply to
> > vhost-user-blk device.
> >
> > After launching vhost-user backend server, I type the following
> > command to connect to it
> >
> > (qemu) chardev-add socket,id=char1,path=/tmp/vhost-user-blk_vhost.socket
> > (qemu) object_add memory-backend-memfd,id=mem,size=256M,share=on
> > (qemu) device_add vhost-user-blk-pci,id=blk0,chardev=char1
> > (qemu) block_resize blk0 512
> > Error: Cannot find device=blk0 nor node_name=
> >
> > QEMU can't find the device although in the guest OS I can already
> > mount /dev/vda. And `info block` doesn't list the newly added
> > vhost-user-blk device,
> > (qemu) info block
> > disk (#block154): dpdk.img (raw)
> >     Attached to:      /machine/peripheral-anon/device[0]
> >     Cache mode:       writeback
> >
> > floppy0: [not inserted]
> >     Attached to:      /machine/unattached/device[17]
> >     Removable device: not locked, tray closed
> >
> > sd0: [not inserted]
> >     Removable device: not locked, tray close
> >
> > It seems `info block` and `block_resize` only work with `drive_add`
> > which is not necessary for vhost-user-blk device.
>
> Yes, -device vhost-user-blk doesn't have a BlockDriverState (-drive or
> -blockdev) because it communicates with the vhost-user device backend
> over a character device instead.
>
> > Should I let QEMU
> > support adding vhost-user backend device in the way similar to adding
> > NBD device(`drive_add -n buddy
> >
> file.driver=nbd,file.host=localhost,file.port=49153,file.export=disk,node-name=nbd_client1`),
> > i.e., a drive can be added via `drive_add -n buddy
> >
> file.driver=vhost-user,file.sock=/tmp/vhost-user-blk_vhost.socket,node-name=vhost_user_client1`?
>
> That is probably too much work.  It's fine to skip test cases that
> resize the disk.
>
> Stefan
>


-- 
*Best regards,*
*Coiby*

--0000000000004c4fc7059b4a25b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for the advice! I&#39;ve skipped test cases rega=
rding resizing the disk. The remaining tests are &quot;indirect&quot; and &=
quot;basic&quot;. vhost-user-blk device has now passed the &quot;basic&quot=
; test (/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/vhost-user-blk-pci/vho=
st-user-blk/vhost-user-blk-tests/basic) as virtio-blk-deivce. But it fails =
the &quot;indirect&quot; test because libvhost-user doesn&#39;t support VIR=
TIO_RING_F_INDIRECT_DESC (indirect buffer descriptors),=C2=A0 Would you sug=
gest me to improve libvhost-user to support=C2=A0indirect buffer descriptor=
s?</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Dec 13, 2019 at 6:58 PM Stefan Hajnoczi &lt;<a href=3D"mailto:ste=
fanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, Dec 11, 2019 at 11:25:32PM +08=
00, Coiby Xu wrote:<br>
&gt; I&#39;m now writing the tests for vhost-user-blk device based on<br>
&gt; tests/virtio-blk-test.c. But block_resize command doesn&#39;t apply to=
<br>
&gt; vhost-user-blk device.<br>
&gt; <br>
&gt; After launching vhost-user backend server, I type the following<br>
&gt; command to connect to it<br>
&gt; <br>
&gt; (qemu) chardev-add socket,id=3Dchar1,path=3D/tmp/vhost-user-blk_vhost.=
socket<br>
&gt; (qemu) object_add memory-backend-memfd,id=3Dmem,size=3D256M,share=3Don=
<br>
&gt; (qemu) device_add vhost-user-blk-pci,id=3Dblk0,chardev=3Dchar1<br>
&gt; (qemu) block_resize blk0 512<br>
&gt; Error: Cannot find device=3Dblk0 nor node_name=3D<br>
&gt; <br>
&gt; QEMU can&#39;t find the device although in the guest OS I can already<=
br>
&gt; mount /dev/vda. And `info block` doesn&#39;t list the newly added<br>
&gt; vhost-user-blk device,<br>
&gt; (qemu) info block<br>
&gt; disk (#block154): dpdk.img (raw)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Attached to:=C2=A0 =C2=A0 =C2=A0 /machine/periphera=
l-anon/device[0]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cache mode:=C2=A0 =C2=A0 =C2=A0 =C2=A0writeback<br>
&gt; <br>
&gt; floppy0: [not inserted]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Attached to:=C2=A0 =C2=A0 =C2=A0 /machine/unattache=
d/device[17]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Removable device: not locked, tray closed<br>
&gt; <br>
&gt; sd0: [not inserted]<br>
&gt;=C2=A0 =C2=A0 =C2=A0Removable device: not locked, tray close<br>
&gt; <br>
&gt; It seems `info block` and `block_resize` only work with `drive_add`<br=
>
&gt; which is not necessary for vhost-user-blk device.<br>
<br>
Yes, -device vhost-user-blk doesn&#39;t have a BlockDriverState (-drive or<=
br>
-blockdev) because it communicates with the vhost-user device backend<br>
over a character device instead.<br>
<br>
&gt; Should I let QEMU<br>
&gt; support adding vhost-user backend device in the way similar to adding<=
br>
&gt; NBD device(`drive_add -n buddy<br>
&gt; file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D49153,file.export=
=3Ddisk,node-name=3Dnbd_client1`),<br>
&gt; i.e., a drive can be added via `drive_add -n buddy<br>
&gt; file.driver=3Dvhost-user,file.sock=3D/tmp/vhost-user-blk_vhost.socket,=
node-name=3Dvhost_user_client1`?<br>
<br>
That is probably too much work.=C2=A0 It&#39;s fine to skip test cases that=
<br>
resize the disk.<br>
<br>
Stefan<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><i>B=
est regards,</i></div><font color=3D"#00cccc"><i>Coiby</i></font><div><font=
 color=3D"#00cccc"><br></font></div></div></div></div></div>

--0000000000004c4fc7059b4a25b6--

