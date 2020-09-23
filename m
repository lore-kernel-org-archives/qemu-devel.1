Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69245C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA81208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEpThUON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA81208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7m5-0000MY-Ns
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kL7jc-0005r3-0L; Wed, 23 Sep 2020 12:35:12 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:40088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kL7jZ-0002Hg-L7; Wed, 23 Sep 2020 12:35:11 -0400
Received: by mail-lf1-x135.google.com with SMTP id m5so580755lfp.7;
 Wed, 23 Sep 2020 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=qY5LCjRSJhoj9UOoEuq9FdKngTsqJz8beTEJpC40ags=;
 b=nEpThUONy5g2V1vmxZVA8+hn+sRIfPNS7voyth3z8dr34HqUxyEEess6AlV3pDXTu8
 04bRAsFnmlPxWLsjjqscC7N1QuSQQnhkURdaZaMsWQ+9TF5k2pJor9wuBlm/UBndXyHK
 Psyc0ZEQJAfur3sKVjeef6I9XS2C9QFpfb90gXOmw/cvwMbzhsBUuqPxf9qHu/MsFtbS
 APFxc7+Q3W/rt8oxEV0qP5uRlqRxnrldMiy+nbjcQ0DXmDWukEpOspCwG0ba8DLQ342S
 nEz+TJKAqP25/hYHU3drUtNMojHm6RAbl3P71hjTrxVU9lhYdb+H+YmpwEVfUUs02uR/
 62aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=qY5LCjRSJhoj9UOoEuq9FdKngTsqJz8beTEJpC40ags=;
 b=tUscpNgFw5k5qUcjf3gv+PQXw9FT45j70zjmkYzGqAYcUVZeuD9ygnKC2cojQZcRAf
 oVGMLlBeuPypsV4LzP0OQbU0gn3HCauwPlAeT23aBSjsmeiVpcbzBRzmml6bK+fjbfgF
 hGna63RSRk2G418CZB7ydEibDrfwMO524AsQkSutoLM44KbVtBH6xMCImBM966X6+SA0
 WcVoxLkebqDOOpYWxGGxGM6twMGv2RYqhhtjrDQ5wT1ycCfDHFe5WjEMVsCuLVkXAmeI
 uU1p2U772nMIBi+lhPm3pM5D03OJTjfCDtl97/N8XwywtTXOwwqE3WRSqXPw639Un3K0
 QrWA==
X-Gm-Message-State: AOAM530YOwOAYB+CLmkpA9/rwJx5DKo8+afOSzsV+TD6heK7qAAXuYh3
 0/KPx+DTy2vw2Zw4DKyBKC6I9GuVeRBrUKLl2Xs=
X-Google-Smtp-Source: ABdhPJztSHHAdArH7j4aPQAOXsltMlewFokHEO32GpTSgPueZ6lcYP2sBQaLX/Glnh+8fWJuq08hK4LOp3jgT1rLJho=
X-Received: by 2002:a19:484d:: with SMTP id v74mr213852lfa.382.1600878906986; 
 Wed, 23 Sep 2020 09:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-P5gngMXmBUtOGNn=ZUN8C2dmC=5Phxs7C5fYV=Odhjw@mail.gmail.com>
 <20200923162908.95372-1-thuth@redhat.com>
In-Reply-To: <20200923162908.95372-1-thuth@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 24 Sep 2020 00:34:55 +0800
Message-ID: <CAE2XoE_BiPL7JH+Uz9VVRHKMiJEHjX7a+FCLv_TEDqa5srAaQA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] configure: Bump the minimum required Python
 version to 3.6
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000945a7105affdaa78"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x135.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000945a7105affdaa78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should we also warning it in meson.build, cause configure finally shoud be
removed.

On Thu, Sep 24, 2020 at 12:32 AM Thomas Huth <thuth@redhat.com> wrote:
>
> All our supported build platforms have Python 3.6 or newer nowadays, and
> there are some useful features in Python 3.6 which are not available in
> 3.5 yet (e.g. the type hint annotations which will allow us to statically
> type the QAPI parser), so let's bump the minimum Python version to 3.6
now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Bump the version in docs/conf.py, too
>  - Remove the now unnecessary check in tests/qemu-iotests/iotests.py
>
>  configure                     | 4 ++--
>  docs/conf.py                  | 4 ++--
>  tests/qemu-iotests/iotests.py | 2 --
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/configure b/configure
> index 7564479008..a3a643168e 100755
> --- a/configure
> +++ b/configure
> @@ -1965,8 +1965,8 @@ fi
>
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
> -  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,6))'; then
> +  error_exit "Cannot use '$python', Python >=3D 3.6 is required." \
>        "Use --python=3D/path/to/python to specify a supported Python."
>  fi
>
> diff --git a/docs/conf.py b/docs/conf.py
> index 0dbd90dc11..8aeac40124 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -36,9 +36,9 @@ from sphinx.errors import ConfigError
>  # In newer versions of Sphinx this will display nicely; in older version=
s
>  # Sphinx will also produce a Python backtrace but at least the
information
>  # gets printed...
> -if sys.version_info < (3,5):
> +if sys.version_info < (3,6):
>      raise ConfigError(
> -        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
> +        "QEMU requires a Sphinx that uses Python 3.6 or better\n")
>
>  # The per-manual conf.py will set qemu_docdir for a single-manual build;
>  # otherwise set it here if this is an entire-manual-set build.
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 91e4a57126..f48460480a 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -40,8 +40,6 @@ sys.path.append(os.path.join(os.path.dirname(__file__),
'..', '..', 'python'))
>  from qemu import qtest
>  from qemu.qmp import QMPMessage
>
> -assert sys.version_info >=3D (3, 6)
> -
>  # Use this logger for logging messages directly from the iotests module
>  logger =3D logging.getLogger('qemu.iotests')
>  logger.addHandler(logging.NullHandler())
> --
> 2.18.2
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000945a7105affdaa78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Should we also warning it in meson.build, cause configure =
finally shoud be removed.<br><br>On Thu, Sep 24, 2020 at 12:32 AM Thomas Hu=
th &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<=
br>&gt;<br>&gt; All our supported build platforms have Python 3.6 or newer =
nowadays, and<br>&gt; there are some useful features in Python 3.6 which ar=
e not available in<br>&gt; 3.5 yet (e.g. the type hint annotations which wi=
ll allow us to statically<br>&gt; type the QAPI parser), so let&#39;s bump =
the minimum Python version to 3.6 now.<br>&gt;<br>&gt; Signed-off-by: Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt;<br>=
&gt; ---<br>&gt; =C2=A0v2:<br>&gt; =C2=A0- Bump the version in docs/conf.py=
, too<br>&gt; =C2=A0- Remove the now unnecessary check in tests/qemu-iotest=
s/iotests.py<br>&gt;<br>&gt; =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>&gt; =C2=A0docs/conf.=
py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<b=
r>&gt; =C2=A0tests/qemu-iotests/iotests.py | 2 --<br>&gt; =C2=A03 files cha=
nged, 4 insertions(+), 6 deletions(-)<br>&gt;<br>&gt; diff --git a/configur=
e b/configure<br>&gt; index 7564479008..a3a643168e 100755<br>&gt; --- a/con=
figure<br>&gt; +++ b/configure<br>&gt; @@ -1965,8 +1965,8 @@ fi<br>&gt;<br>=
&gt; =C2=A0# Note that if the Python conditional here evaluates True we wil=
l exit<br>&gt; =C2=A0# with status 1 which is a shell &#39;false&#39; value=
.<br>&gt; -if ! $python -c &#39;import sys; sys.exit(sys.version_info &lt; =
(3,5))&#39;; then<br>&gt; - =C2=A0error_exit &quot;Cannot use &#39;$python&=
#39;, Python &gt;=3D 3.5 is required.&quot; \<br>&gt; +if ! $python -c &#39=
;import sys; sys.exit(sys.version_info &lt; (3,6))&#39;; then<br>&gt; + =C2=
=A0error_exit &quot;Cannot use &#39;$python&#39;, Python &gt;=3D 3.6 is req=
uired.&quot; \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Use --python=3D/pat=
h/to/python to specify a supported Python.&quot;<br>&gt; =C2=A0fi<br>&gt;<b=
r>&gt; diff --git a/docs/conf.py b/docs/conf.py<br>&gt; index 0dbd90dc11..8=
aeac40124 100644<br>&gt; --- a/docs/conf.py<br>&gt; +++ b/docs/conf.py<br>&=
gt; @@ -36,9 +36,9 @@ from sphinx.errors import ConfigError<br>&gt; =C2=A0#=
 In newer versions of Sphinx this will display nicely; in older versions<br=
>&gt; =C2=A0# Sphinx will also produce a Python backtrace but at least the =
information<br>&gt; =C2=A0# gets printed...<br>&gt; -if sys.version_info &l=
t; (3,5):<br>&gt; +if sys.version_info &lt; (3,6):<br>&gt; =C2=A0 =C2=A0 =
=C2=A0raise ConfigError(<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;QEMU re=
quires a Sphinx that uses Python 3.5 or better\n&quot;)<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;QEMU requires a Sphinx that uses Python 3.6 or be=
tter\n&quot;)<br>&gt;<br>&gt; =C2=A0# The per-manual conf.py will set qemu_=
docdir for a single-manual build;<br>&gt; =C2=A0# otherwise set it here if =
this is an entire-manual-set build.<br>&gt; diff --git a/tests/qemu-iotests=
/iotests.py b/tests/qemu-iotests/iotests.py<br>&gt; index 91e4a57126..f4846=
0480a 100644<br>&gt; --- a/tests/qemu-iotests/iotests.py<br>&gt; +++ b/test=
s/qemu-iotests/iotests.py<br>&gt; @@ -40,8 +40,6 @@ sys.path.append(os.path=
.join(os.path.dirname(__file__), &#39;..&#39;, &#39;..&#39;, &#39;python&#3=
9;))<br>&gt; =C2=A0from qemu import qtest<br>&gt; =C2=A0from qemu.qmp impor=
t QMPMessage<br>&gt;<br>&gt; -assert sys.version_info &gt;=3D (3, 6)<br>&gt=
; -<br>&gt; =C2=A0# Use this logger for logging messages directly from the =
iotests module<br>&gt; =C2=A0logger =3D logging.getLogger(&#39;qemu.iotests=
&#39;)<br>&gt; =C2=A0logger.addHandler(logging.NullHandler())<br>&gt; --<br=
>&gt; 2.18.2<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000945a7105affdaa78--

