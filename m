Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B72CC3F2CE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AE320738
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtG4UtKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AE320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnmr-0005XD-O4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jDn2X-00066y-3I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jDn2V-0004Sx-9A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jDn2U-0004GG-6u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584354725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFcbtMS/hpw3yhNbIyrc9jgaP4QKJD1YXrjHYWxI/mo=;
 b=HtG4UtKX2efxQo9Gx+TaN4KKbgPkaLhojvnGYTavAmHQNq8vjlwsoBnsxJQuIN39Sivzcv
 5n5jdzcGmL4zP72Vt9AgDF0Wx5K0lxvSl1Rz9dk58/qf7zutfTDN1LzDtVh/vvBfYeyugr
 TpJgxOW/55wc3LcU/38vxp47m/JmOrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-q41N8ZubOcy463Gmo8Pm2g-1; Mon, 16 Mar 2020 06:32:01 -0400
X-MC-Unique: q41N8ZubOcy463Gmo8Pm2g-1
Received: by mail-wr1-f71.google.com with SMTP id 31so8874905wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 03:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wIyZD+h27+HD5doiVTIwX+4CYtLxPHPLR3NAQwv1IZQ=;
 b=g3T6IPq94reGZbYADlVzrkKlH/Yzn9IceaNHwdyy/1zRChBfE4X/BLyaHMK2HYCKtY
 bNmfhPpYou1hgHz9Spbh+XxE/Hx1jSqXBY2zXmoizwjFwUXzxqrKpONV1RuZoil0WHHD
 QFHYVeq6rAZk4zGMw62c6koVqeEirgdJ+vM8BtD8dkUQS65hbJeOdGrYQoQoLBF6gmv+
 ZK+JWMuKTgnYT0UnyJO/DWU72hwyyCjjx+vGHFR0QmukNmv9jKbpId04y0V/0hrxeSrg
 q7CrfBCzt7GHbE/mBDdfCqCJdGmuQSqCXeqpUxZu1z3VyzvBpKIDQst8ede5VWuSkEZR
 lqqA==
X-Gm-Message-State: ANhLgQ28os+V71jJUdHpPTKjSAhFPe+35w91aeJKRoOXfQMoGoEVp8w2
 FEREi27SW4Ug+VY83zTZvQAHaCsjxKAfrgN+vBOSKanKt7uQKGcs3jnrVEFe8iPKhTRDj7T6cFC
 P+taAKwu2FjYtica9uoECGDtBc4FnPoA=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr26333196wme.36.1584354720594; 
 Mon, 16 Mar 2020 03:32:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtuJW+kKalDC9m03yqYctpvYWj2iSEyHQGswsVBCqwWq2Ob165ahaVJ5PUoIIfqft9iT1BAqXJ1dBBkqIgs6w4=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr26333176wme.36.1584354720328; 
 Mon, 16 Mar 2020 03:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200312140547.20448-1-ovoshcha@redhat.com>
 <20200312173013.GR1187748@habkost.net>
In-Reply-To: <20200312173013.GR1187748@habkost.net>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Mon, 16 Mar 2020 12:31:49 +0200
Message-ID: <CAMXCgj697x8zOy40Z1vZ=Y=3VDQSP3J39JkKZogQVRmz-SCkPg@mail.gmail.com>
Subject: Re: [PATCH v2] python/qemu/qmp.py: QMP debug with VM label
To: Eduardo Habkost <ehabkost@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000004dee8c05a0f65441"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004dee8c05a0f65441
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eduardo
I'm already fixing it.

Thank you,

On Sun, Mar 15, 2020 at 5:39 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> On Thu, Mar 12, 2020 at 04:05:47PM +0200, Oksana Vohchana wrote:
> > QEMUMachine writes some messages to the default logger.
> > But it sometimes hard to read the output if we have requests to
> > more than one VM.
> > This patch adds a label to the logger in the debug mode.
> >
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> >
> > ---
> > v2:
> >  - Instead of shown the label in the message it provides the label
> >    only in the debug logger information
> > ---
> >  python/qemu/machine.py | 2 +-
> >  python/qemu/qmp.py     | 5 ++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index 183d8f3d38..d0aa774c1c 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -270,7 +270,7 @@ class QEMUMachine(object):
> >                  self._vm_monitor =3D os.path.join(self._sock_dir,
> >                                                  self._name +
> "-monitor.sock")
> >                  self._remove_files.append(self._vm_monitor)
> > -            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
> server=3DTrue)
> > +            self._qmp =3D qmp.QEMUMonitorProtocol(self._vm_monitor,
> server=3DTrue, nickname=3Dself._name)
> >
> >      def _post_launch(self):
> >          if self._qmp:
> > diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> > index f40586eedd..d58b18c304 100644
> > --- a/python/qemu/qmp.py
> > +++ b/python/qemu/qmp.py
> > @@ -46,7 +46,7 @@ class QEMUMonitorProtocol:
> >      #: Logger object for debugging messages
> >      logger =3D logging.getLogger('QMP')
>
> This will create a single logger instance.
>
> >
> > -    def __init__(self, address, server=3DFalse):
> > +    def __init__(self, address, server=3DFalse, nickname=3DNone):
> >          """
> >          Create a QEMUMonitorProtocol class.
> >
> > @@ -62,6 +62,7 @@ class QEMUMonitorProtocol:
> >          self.__address =3D address
> >          self.__sock =3D self.__get_sock()
> >          self.__sockfile =3D None
> > +        self._nickname =3D nickname
> >          if server:
> >              self.__sock.setsockopt(socket.SOL_SOCKET,
> socket.SO_REUSEADDR, 1)
> >              self.__sock.bind(self.__address)
> > @@ -188,6 +189,8 @@ class QEMUMonitorProtocol:
> >          @return QMP response as a Python dict or None if the connectio=
n
> has
> >                  been closed
> >          """
> > +        if self._nickname:
> > +            self.logger.name =3D 'QMP.{}'.format(self._nickname)
>
> This will change the name of that single instance and affect
> every single QEMUMonitorProtocol object.  Please don't do that.
>
> You can just do:
>
>     self.logger =3D logging.getLogger('QMP').getChild(self._nickname)
>
> at __init__().
>
>
> >          self.logger.debug(">>> %s", qmp_cmd)
> >          try:
> >              self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
> > --
> > 2.21.1
> >
>
> --
> Eduardo
>
>

--0000000000004dee8c05a0f65441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Eduardo<div>I&#39;m already fixin=
g it.<br></div><div><br></div><div>Thank you,<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 15, 2020=
 at 5:39 PM Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehab=
kost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Thu, Mar 12, 2020 at 04:05:47PM +0200, Oksana Vohchana wr=
ote:<br>
&gt; QEMUMachine writes some messages to the default logger.<br>
&gt; But it sometimes hard to read the output if we have requests to<br>
&gt; more than one VM.<br>
&gt; This patch adds a label to the logger in the debug mode.<br>
&gt; <br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 - Instead of shown the label in the message it provides the labe=
l<br>
&gt;=C2=A0 =C2=A0 only in the debug logger information<br>
&gt; ---<br>
&gt;=C2=A0 python/qemu/machine.py | 2 +-<br>
&gt;=C2=A0 python/qemu/qmp.py=C2=A0 =C2=A0 =C2=A0| 5 ++++-<br>
&gt;=C2=A0 2 files changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/python/qemu/machine.py b/python/qemu/machine.py<br>
&gt; index 183d8f3d38..d0aa774c1c 100644<br>
&gt; --- a/python/qemu/machine.py<br>
&gt; +++ b/python/qemu/machine.py<br>
&gt; @@ -270,7 +270,7 @@ class QEMUMachine(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._vm=
_monitor =3D os.path.join(self._sock_dir,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._name + &quot;-monitor.sock&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._re=
move_files.append(self._vm_monitor)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp =3D qmp.QEMUMonit=
orProtocol(self._vm_monitor, server=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._qmp =3D qmp.QEMUMonit=
orProtocol(self._vm_monitor, server=3DTrue, nickname=3Dself._name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def _post_launch(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._qmp:<br>
&gt; diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py<br>
&gt; index f40586eedd..d58b18c304 100644<br>
&gt; --- a/python/qemu/qmp.py<br>
&gt; +++ b/python/qemu/qmp.py<br>
&gt; @@ -46,7 +46,7 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 #: Logger object for debugging messages<br>
&gt;=C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(&#39;QMP&#39;)<br>
<br>
This will create a single logger instance.<br>
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def __init__(self, address, server=3DFalse):<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, address, server=3DFalse, nickname=3D=
None):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create a QEMUMonitorProtocol class.<=
br>
&gt;=C2=A0 <br>
&gt; @@ -62,6 +62,7 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__address =3D address<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sock =3D self.__get_sock()<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sockfile =3D None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._nickname =3D nickname<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if server:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sock.setsockopt=
(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sock.bind(self.=
__address)<br>
&gt; @@ -188,6 +189,8 @@ class QEMUMonitorProtocol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @return QMP response as a Python dic=
t or None if the connection has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 been clo=
sed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._nickname:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logg=
er.name" rel=3D"noreferrer" target=3D"_blank">self.logger.name</a> =3D &#39=
;QMP.{}&#39;.format(self._nickname)<br>
<br>
This will change the name of that single instance and affect<br>
every single QEMUMonitorProtocol object.=C2=A0 Please don&#39;t do that.<br=
>
<br>
You can just do:<br>
<br>
=C2=A0 =C2=A0 self.logger =3D logging.getLogger(&#39;QMP&#39;).getChild(sel=
f._nickname)<br>
<br>
at __init__().<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.debug(&quot;&gt;&gt;&gt;=
 %s&quot;, qmp_cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.__sock.sendall(js=
on.dumps(qmp_cmd).encode(&#39;utf-8&#39;))<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt; <br>
<br>
-- <br>
Eduardo<br>
<br>
</blockquote></div></div>

--0000000000004dee8c05a0f65441--


