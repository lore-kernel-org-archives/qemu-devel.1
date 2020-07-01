Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E599207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxdVX85e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E599207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqd7k-0003lA-Gw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqd7A-0003L4-GH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:49:28 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqd78-0004bL-Lx
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:49:28 -0400
Received: by mail-lj1-x242.google.com with SMTP id s9so26991570ljm.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=emiEx+ALUlo6ZnfKOzaq/E6ivEL1AUnV1oKB9XNQhRw=;
 b=mxdVX85elObQbQkEPpekADzD5YJ2FGKH49laLwiHO9rcmH5w0BAMC/g942oTRzB6MX
 MkPYwjBxlJgnnzlDIG+JhO+dGSJAx2RXeSyX4LFq0TYKra5rbS0E/hNWMOtu/QAEHeyP
 gVuuWNhUVDNZ3QFZjKzxDk+KjITkh4TrRvU7y1pt4IzgJdSKLonGBMUYxjROY8CiDKX7
 kTrK3UbYSuA9Gc7pPBlsJog22gsuO7LE1LnL4uRua4M+tmYAxjzgCD5uMOJDaoiiGvvN
 5fVa4tTuaMyG5A0Z9PzHk1KfVvvpEAoIhYYh1+wB/AmMg/dzsbkdhdjyc4W3ZkeqOus8
 uqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=emiEx+ALUlo6ZnfKOzaq/E6ivEL1AUnV1oKB9XNQhRw=;
 b=qi2a76QWwQa7ZXrDk6Cqg1YWDzlW2ksYbZvTGw6cHLLfEsYk4bN4X6LGVPqkyzCf5d
 4zSrU+LvceA8JVQPAsgXdj+KB9rO4xQ5M3zxdgnb4xWYfh1AR8u9u+DEgi44908BojtM
 W/0K0PfuAYfusxlougN1qfsMDQWHniamgL3CZn0rdL32h0m/nszr0bJOfxWb+prEb/Q4
 XouyHFTAYiH/OwUeWPQurz6MzQw3lxYJhHMREqgqXyE3I+k3gl9AFAIS9JcJQT3nhpD+
 tZ6LHNPbW/3NucEcv11MEMeN87uZs65SB+1G9BQpx7yy3SGha+lWBzWBc/OqipyCuRwZ
 nhTQ==
X-Gm-Message-State: AOAM533MheXYH5CErGCzN/QtRy2s0drMzl9Gk5WGI0Q3CAN6IfyrWmXA
 tutbA9kC4uK+GbvuGGdw3PNFj6ZX2onw+WsSH6E=
X-Google-Smtp-Source: ABdhPJzblzYmE2+O69SuDMZ4AB+nOAJaFTwl5Fg0OJVHyrkbIzuo3Q8FQD1WXSxDGi9TWtXrQgNWkxTv0O0Rob98LFo=
X-Received: by 2002:a2e:3a15:: with SMTP id h21mr1697456lja.112.1593611364717; 
 Wed, 01 Jul 2020 06:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200701130433.1506-1-ahmedkhaledkaraman@gmail.com>
 <20200701130433.1506-2-ahmedkhaledkaraman@gmail.com>
 <06a0026e-f7cc-9a15-bc0e-d6c6c4846caf@redhat.com>
In-Reply-To: <06a0026e-f7cc-9a15-bc0e-d6c6c4846caf@redhat.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 1 Jul 2020 15:48:48 +0200
Message-ID: <CALTWKrV-ho8VXA3dGFXYeiHeQzvN4bzrgbdJ3Woe9SuS4Fg1=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/performance: Add dissect.py script
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, luoyonggang@gmail.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 3:41 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 7/1/20 8:04 AM, Ahmed Karaman wrote:
> > Python script that dissects QEMU execution into three main phases:
> > code generation, JIT execution and helpers execution.
> >
> > Syntax:
> > dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
> >                   <target executable> [<target executable options>]
> >
> > [-h] - Print the script arguments help message.
> >
> > Example of usage:
> > dissect.py -- qemu-arm coulomb_double-arm
>
> Given the example usage...
>
> >
> > Example output:
> > Total Instructions:        4,702,865,362
> >
> > Code Generation:             115,819,309       2.463%
> > JIT Execution:             1,081,980,528      23.007%
> > Helpers:                   3,505,065,525      74.530%
> >
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > ---
> >   scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
> >   1 file changed, 165 insertions(+)
> >   create mode 100644 scripts/performance/dissect.py
> >
> > diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
> > new file mode 100644
>
> ...this should have the executable bit set.
Thanks Mr. Eric, I don't know why I always forget doing this before
sending the patch. Will do it in V2.
>
>
> > +def get_JIT_line(callgrind_data):
> > +    """
> > +    Search for the first instance of the JIT call in
> > +    the callgrind_annoutate output when ran using --tree=caller
>
> annotate
Thanks.

>
> > +    This is equivalent to the self number of instructions of JIT.
> > +
> > +    Parameters:
> > +    callgrind_data (list): callgrind_annotate output
> > +
> > +    Returns:
> > +    (int): Line number
> > +   """
> > +    line = -1
> > +    for i in range(len(callgrind_data)):
> > +        if callgrind_data[i].strip('\n') and \
> > +                callgrind_data[i].split()[-1] == "[???]":
> > +            line = i
> > +            break
> > +    if line == -1:
> > +        sys.exit("Couldn't locate the JIT call ... Exiting!")
>
> We tend to avoid ! at the end of error messages (it can come across as
> shouting at the user).
Yeah right, Will remove the exclamations.
>
> > +    return line
> > +
> > +
> > +def main():
> > +    # Parse the command line arguments
> > +    parser = argparse.ArgumentParser(
> > +        usage='dissect.py [-h] -- '
> > +        '<qemu executable> [<qemu executable options>] '
> > +        '<target executable> [<target executable options>]')
> > +
> > +    parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
> > +
> > +    args = parser.parse_args()
> > +
> > +    # Extract the needed variables from the args
> > +    command = args.command
> > +
> > +    # Insure that valgrind is installed
> > +    check_valgrind = subprocess.run(
> > +        ["which", "valgrind"], stdout=subprocess.DEVNULL)
> > +    if check_valgrind.returncode:
> > +        sys.exit("Please install valgrind before running the script!")
>
> and again
Noted.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
Thanks for your feedback Mr. Eric.

Best regards,
Ahmed Karaman

