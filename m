Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E969420674
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+jN7eS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E969420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibq1n-0001Kz-VZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibq0q-0000pD-6f
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibq0o-00083V-5F
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:01:31 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibq0n-00083E-7h
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:01:29 -0500
Received: by mail-oi1-x244.google.com with SMTP id j22so471112oij.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LR3UhdiVwMNdCldcw6nIwFd2BwLrJZBGa0G+yUp/Y00=;
 b=C+jN7eS5sK47mcT1WEWpV7TUy65nNv7qdpb/Cu1pq9EtiBXa4meNwMOYmcbyASCRFL
 SBW3KcFAP+DgM2DPwDbW8JohUlqswl8hEyWtNywcepXtMVeOG66IPa0YlUQnZNgX1uWt
 nnFyP6y6FOD029WL596hDwAo2vmKpiLM96GKNXmJq2oVvuzLcpqyJ5zkPHcwDPFawuoa
 pn3c6giUt9SPvvh/dwgu60IZGz+rODcE4qk3rUhtLpdmk78B+P4rlJlVHBF6x/H5lYiy
 JjBnryByIANxuD+gfAh+Hm0yGuslkRe/XqvY1sNlFJHDAJcoospZpNc+e5g1OJRy2H4b
 1msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LR3UhdiVwMNdCldcw6nIwFd2BwLrJZBGa0G+yUp/Y00=;
 b=jfQWkV0NkE5DT9kkZGki3JmX3OCUffA6hLV0VYnePIrGTkADH4l4VeIjTjEAqyTnC+
 yjF4pgWdHqL+fy9GofrzdDo3H+1H+uRJGz3NrowoHT1GmVQW351pj4MaZJ0ixyABzeGS
 OVtUO7kGG5O+1HRfkP1J6jRt9XrJXr74nFBJwdfF4AlK1D04KGA7ljAxUGkeFET7espN
 +OP+iyK6nkDGjDNhvRUKVvu73+P3GivV+mq1/uDHXyZNAKso1cJmBMABS/TAtxrJShSl
 2fwYHZPf2MXmchrbQm9ezYtlTpYxW/k3IZr+Z7xEFr/j4JtfFxKV41VxWeZJ02xI+HZY
 O7qg==
X-Gm-Message-State: APjAAAXPUOe1DCttnkP5N4n+h8ZKiBWBuTQjsHBjotDw/eyk5gPMNOHC
 Rzjr7T8WkYb80iPCg0pBJyYWmnXhvqr+CeNZMxW+cg==
X-Google-Smtp-Source: APXvYqzmb9/+UddteHMgFs3CvmoIPP46o/Lum+d1VX1fU+LCAN6qwfSzDvq7z+5dw/nwX3peKLEdwWXF0m3mj1wiJ6U=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr229410oia.146.1575309687958; 
 Mon, 02 Dec 2019 10:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
In-Reply-To: <20191129140217.17797-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 18:01:16 +0000
Message-ID: <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 14:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Surprisingly, QEMU does have a pretty consistent doc comment style and
> it is not very different from the Linux kernel's.  Of the documentation
> "sigils", only "#" separates the QEMU doc comment style from Linux's,
> and it has 200+ instances vs. 6 for the kernel's '&struct foo' (all in
> accel/tcg/translate-all.c), so it's clear that the two standards are
> different in this respect.  In addition, our structs are typedefed and
> recognized by CamelCase names.
>
> Adjust kernel-doc's parser for these two aspects of the QEMU coding
> standards.  The patch has been valid, with hardly any change, for over
> two years, so it should not be an issue to keep kernel-doc in sync with
> the Linux copy.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/kernel-doc | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 81dc91760b..af470eb321 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -215,12 +215,12 @@ my $type_func = '(\w+)\(\)';
>  my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>  my $type_env = '(\$\w+)';
> -my $type_enum = '\&(enum\s*([_\w]+))';
> -my $type_struct = '\&(struct\s*([_\w]+))';
> -my $type_typedef = '\&(typedef\s*([_\w]+))';
> -my $type_union = '\&(union\s*([_\w]+))';
> -my $type_member = '\&([_\w]+)(\.|->)([_\w]+)';
> -my $type_fallback = '\&([_\w]+)';
> +my $type_enum = '#(enum\s*([_\w]+))';
> +my $type_struct = '#(struct\s*([_\w]+))';
> +my $type_typedef = '#(([A-Z][_\w]*))';
> +my $type_union = '#(union\s*([_\w]+))';
> +my $type_member = '#([_\w]+)(\.|->)([_\w]+)';

perlre(1) says that \w includes _' so I think
'[_\w]' is a funny way of writing '\w', but on
the other hand it's in the existing code too...

> +my $type_fallback = '(?!)';    # this never matches
>  my $type_member_func = $type_member . '\(\)';
>
>  # Output conversion substitutions.
> @@ -1050,6 +1050,14 @@ sub output_blockhead {
>  sub dump_declaration($$) {
>      no strict 'refs';
>      my ($prototype, $file) = @_;
> +    if ($decl_type eq 'type name') {
> +       if ($prototype =~ /^(enum|struct|union)\s+/) {
> +          $decl_type = $1;
> +       } else {
> +          return;
> +       }
> +    }
> +
>      my $func = "dump_" . $decl_type;
>      &$func(@_);
>  }
> @@ -1878,7 +1886,7 @@ sub process_name($$) {
>      }
>      elsif (/$doc_decl/o) {
>         $identifier = $1;
> -       if (/\s*([\w\s]+?)(\(\))?\s*-/) {
> +       if (/\s*([\w\s]+?)(\s*-|:)/) {
>             $identifier = $1;
>         }
>
> @@ -1888,7 +1896,7 @@ sub process_name($$) {
>         $contents = "";
>         $section = $section_default;
>         $new_start_line = $. + 1;
> -       if (/-(.*)/) {
> +       if (/[-:](.*)/) {
>             # strip leading/trailing/multiple spaces
>             $descr= $1;
>             $descr =~ s/^\s*//;

These two bits seem to be a third thing not mentioned
in the commit message -- permitting either colon or
hyphen in the "Thing: short description" introductory line,
where kernel style insists on a hyphen.

(You could make the argument that this is an unnecessary
drift from the kernel-doc style and we should just fix
up all those colons...)

> @@ -1906,7 +1914,9 @@ sub process_name($$) {
>             ++$warnings;
>         }
>
> -       if ($identifier =~ m/^struct\b/) {
> +       if ($identifier =~ m/^[A-Z]/) {
> +           $decl_type = 'type name';
> +       } elsif ($identifier =~ m/^struct\b/) {
>             $decl_type = 'struct';
>         } elsif ($identifier =~ m/^union\b/) {
>             $decl_type = 'union';

The match for 'type name' is pretty wide but I guess
we can find out through experience if we need to narrow it.

thanks
-- PMM

