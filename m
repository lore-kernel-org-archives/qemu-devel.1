Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E0C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA1C206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzoUAI60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA1C206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJbz-00079P-8s
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jGJbL-0006hR-4z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jGJbJ-0007lr-6D
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:42:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jGJbI-0007le-WB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584956548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVzp5FgCwJWHJ3HfY4o/lRwpBPQ5rEqH+z/2nhW1+Ss=;
 b=KzoUAI60kQYKQ+1ZyA9PgqT8LrYdZOZJLVDkwGsOGGlfVF3Fu1i5FN83ek8zuKbNF9A0Mk
 xxstkVJSL3c4xxp87694d6drESYBkb/bw9TZw2RkYWb+ZgAH23DWw02dynWEDu8hMygy9J
 6NLNw1cTC0UNbfcALLt41kRYvg7r7jI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-zHdaJisbONmwrooqY-3GIg-1; Mon, 23 Mar 2020 05:42:25 -0400
X-MC-Unique: zHdaJisbONmwrooqY-3GIg-1
Received: by mail-wr1-f69.google.com with SMTP id q18so7082774wrw.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 02:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5rTWkQ9Q0WFB+WucsYwF0erVXGngPH7/eCbGamiLY8=;
 b=LNxCJM02tiVZ2IHGb4GDy+QaMKaCUIfFEtDjaUp4TWeLsEJF1G3NsrPfLqkAtu9tpV
 KD/J0Ent9zsSaDUfsLpfMdWDkavKx2gTd2X6HYJSxzNB8SrDX928UowuNh9uQFEmb+HN
 gdYo0B+7+GGuRAaoaNIipyZ0PamkNNcLZ8eq/RF6n2MYYa/Dx5/ThcqA0OXTaIr68Tfx
 PQIQAZc4VjY4tfz/zEbudw7/PinQGB1/qLAoFv3wN0EIWQRTpvYICyDG+LWLul75jEND
 gvM0kNhSeF/BM1d1+BZwb93CLGtjkyR/1DX8jAHfeEf+kp/8+wlGOJLYE4fxfp1VluJh
 lGFQ==
X-Gm-Message-State: ANhLgQ0D2ZL6BKeXUSgOCdVhI88FimydZnZhSAwqTYSJWaQ70il95HyA
 Qh9kplBd4gQc7084oKG/oqQm1Hh7p0eLyupj7NwTjodWg558pDmZ5Wg5lTUX/u/dn5J15251SCE
 PjxlHZ8wZOVn+i7h4n5unvUfZS3w/0jM=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr25436684wme.36.1584956544590; 
 Mon, 23 Mar 2020 02:42:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQWo2XFqE+Z4Xk/8quaAyAd4nslGKoE67h/qe/AWC8uK9QdGWPs9YiNDDPePBsO1GwkT5nMHwNc9PRR5zxfsw=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr25436666wme.36.1584956544349; 
 Mon, 23 Mar 2020 02:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151254.16766-1-ovoshcha@redhat.com>
 <20200320151254.16766-3-ovoshcha@redhat.com>
 <CAKJDGDYf=_OUojiiB0MxS-j03kmpLzoCq8U8arSbBGTN0sS+4g@mail.gmail.com>
In-Reply-To: <CAKJDGDYf=_OUojiiB0MxS-j03kmpLzoCq8U8arSbBGTN0sS+4g@mail.gmail.com>
From: Oksana Voshchana <ovoshcha@redhat.com>
Date: Mon, 23 Mar 2020 11:42:13 +0200
Message-ID: <CAMXCgj5UvMCfAj9wZu5X-1KMc5gFCeQA9xiMtPX7yeWAMfpHjw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Acceptance test: provides new functions
To: Willian Rampazzo <wrampazz@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000cf8d0f05a1827386"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cf8d0f05a1827386
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willian
I totally agree with your comments
I'll move those functions outside the class
Let me update and repost the patch
Thanks

On Fri, Mar 20, 2020 at 6:22 PM Willian Rampazzo <wrampazz@redhat.com>
wrote:

> Hi Oksana,
>
> On Fri, Mar 20, 2020 at 12:15 PM Oksana Vohchana <ovoshcha@redhat.com>
> wrote:
> >
> > Provides new functions related to the rdma migration test
> > Adds functions to check if service RDMA is enabled and gets
> > the ip address on the interface where it was configured
> >
> > Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> > ---
> >  tests/acceptance/migration.py | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/tests/acceptance/migration.py
> b/tests/acceptance/migration.py
> > index e4c39b85a1..a783f3915b 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -11,12 +11,17 @@
> >
> >
> >  import tempfile
> > +import json
> >  from avocado_qemu import Test
> >  from avocado import skipUnless
> >
> >  from avocado.utils import network
> >  from avocado.utils import wait
> >  from avocado.utils.path import find_command
> > +from avocado.utils.network.interfaces import NetworkInterface
> > +from avocado.utils.network.hosts import LocalHost
> > +from avocado.utils import service
> > +from avocado.utils import process
> >
> >
> >  class Migration(Test):
> > @@ -58,6 +63,31 @@ class Migration(Test):
> >              self.cancel('Failed to find a free port')
> >          return port
> >
> > +    def _if_rdma_enable(self):
> > +        rdma_stat =3D service.ServiceManager()
> > +        rdma =3D rdma_stat.status('rdma')
> > +        return rdma
>
> You can just `return rdma_stat.status('rdma')` here! Also, as you are
> not using any of the class attributes or methods, if you make this
> method static, you don't need to call it with `None` as you did on
> patch 3 of this series.
>
> > +
> > +    def _get_interface_rdma(self):
> > +        cmd =3D 'rdma link show -j'
> > +        out =3D json.loads(process.getoutput(cmd))
> > +        try:
> > +            for i in out:
> > +                if i['state'] =3D=3D 'ACTIVE':
> > +                    return i['netdev']
> > +        except KeyError:
> > +            return None
>
> Same comment about making this method static.
>
> Actually, if you are not using any of the attributes or methods from
> the Migration class on these two methods, I think you can define them
> as functions, outside of the Class. Does it make sense?
>
> > +
> > +    def _get_ip_rdma(self, interface):
> > +        local =3D LocalHost()
> > +        network_in =3D NetworkInterface(interface, local)
> > +        try:
> > +            ip =3D network_in._get_interface_details()
> > +            if ip:
> > +                return ip[0]['addr_info'][0]['local']
> > +        except:
> > +            self.cancel("Incorrect interface configuration or device
> name")
> > +
>
> If you change the logic a bit and raise an exception here, instead of
> doing a `self.cancel`, you can also make this method static, or move
> it outside of the class. The cancel can be handled in the test, with
> the exception raised here.
>
> >
> >      def test_migration_with_tcp_localhost(self):
> >          dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
> > --
> > 2.21.1
> >
> >
>
> Let me know if the comments do not make sense.
>
> Willian
>
>

--000000000000cf8d0f05a1827386
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Willian<div>I totally agree with your comments<br>=
I&#39;ll move those functions outside the class<br>Let me update and repost=
 the patch<br>Thanks</div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Fri, Mar 20, 2020 at 6:22 PM Willian Rampazzo =
&lt;<a href=3D"mailto:wrampazz@redhat.com">wrampazz@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Oksana,<br=
>
<br>
On Fri, Mar 20, 2020 at 12:15 PM Oksana Vohchana &lt;<a href=3D"mailto:ovos=
hcha@redhat.com" target=3D"_blank">ovoshcha@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Provides new functions related to the rdma migration test<br>
&gt; Adds functions to check if service RDMA is enabled and gets<br>
&gt; the ip address on the interface where it was configured<br>
&gt;<br>
&gt; Signed-off-by: Oksana Vohchana &lt;<a href=3D"mailto:ovoshcha@redhat.c=
om" target=3D"_blank">ovoshcha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/acceptance/migration.py | 30 +++++++++++++++++++++++++++++=
+<br>
&gt;=C2=A0 1 file changed, 30 insertions(+)<br>
&gt;<br>
&gt; diff --git a/tests/acceptance/migration.py b/tests/acceptance/migratio=
n.py<br>
&gt; index e4c39b85a1..a783f3915b 100644<br>
&gt; --- a/tests/acceptance/migration.py<br>
&gt; +++ b/tests/acceptance/migration.py<br>
&gt; @@ -11,12 +11,17 @@<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 import tempfile<br>
&gt; +import json<br>
&gt;=C2=A0 from avocado_qemu import Test<br>
&gt;=C2=A0 from avocado import skipUnless<br>
&gt;<br>
&gt;=C2=A0 from avocado.utils import network<br>
&gt;=C2=A0 from avocado.utils import wait<br>
&gt;=C2=A0 from avocado.utils.path import find_command<br>
&gt; +from avocado.utils.network.interfaces import NetworkInterface<br>
&gt; +from avocado.utils.network.hosts import LocalHost<br>
&gt; +from avocado.utils import service<br>
&gt; +from avocado.utils import process<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 class Migration(Test):<br>
&gt; @@ -58,6 +63,31 @@ class Migration(Test):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cancel(&#39;Faile=
d to find a free port&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return port<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 def _if_rdma_enable(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma_stat =3D service.ServiceManager()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rdma =3D rdma_stat.status(&#39;rdma&#39;)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rdma<br>
<br>
You can just `return rdma_stat.status(&#39;rdma&#39;)` here! Also, as you a=
re<br>
not using any of the class attributes or methods, if you make this<br>
method static, you don&#39;t need to call it with `None` as you did on<br>
patch 3 of this series.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _get_interface_rdma(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &#39;rdma link show -j&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D json.loads(process.getoutput(cmd)=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in out:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if i[&#39;sta=
te&#39;] =3D=3D &#39;ACTIVE&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return i[&#39;netdev&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except KeyError:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return None<br>
<br>
Same comment about making this method static.<br>
<br>
Actually, if you are not using any of the attributes or methods from<br>
the Migration class on these two methods, I think you can define them<br>
as functions, outside of the Class. Does it make sense?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _get_ip_rdma(self, interface):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 local =3D LocalHost()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 network_in =3D NetworkInterface(interface=
, local)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip =3D network_in._get_inte=
rface_details()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ip:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ip[0][=
&#39;addr_info&#39;][0][&#39;local&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cancel(&quot;Incorrect=
 interface configuration or device name&quot;)<br>
&gt; +<br>
<br>
If you change the logic a bit and raise an exception here, instead of<br>
doing a `self.cancel`, you can also make this method static, or move<br>
it outside of the class. The cancel can be handled in the test, with<br>
the exception raised here.<br>
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def test_migration_with_tcp_localhost(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dest_uri =3D &#39;tcp:localhost:%u&#=
39; % self._get_free_port()<br>
&gt; --<br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
<br>
Let me know if the comments do not make sense.<br>
<br>
Willian<br>
<br>
</blockquote></div>

--000000000000cf8d0f05a1827386--


