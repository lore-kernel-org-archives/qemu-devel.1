Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45153C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB37218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB37218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higCa-0001ke-4M
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54262)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1higBT-0001D7-L0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1higBS-0002qE-Cp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:24:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1higBR-0002os-MP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:24:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so2630272wmm.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xtpsoeQfhYH2pNurTU4rwf4TjUPQfDEg467BhYq/Pd0=;
 b=nMRCmx0Bf94zeppBIPjsivapgRz6Vyf4WLrLarIfhKfzLdAJeRFbvnCK3g4AN1DmYu
 jMjnwcXREOP0+fZYAsEdW0JwLRrsrDFa1Jf1T2uMFXSS/+BgpvX17MDRP9SLiBj886TK
 ICW4ILEcHJ9EUmxbGAcA6LU7n2we6i9vLni4q8qS4G3nwQPx8frUss3L2z9cGC/wwb8J
 m8NTnpZG3vSF9Edr30DbY9USi5bhou3HE6pGwz9J1NHEU7C2UXu1r0LZdCU5+8XpOMd/
 Evhdk94mgSKj9E+xBqTBIOVtIgU69OWFRBMpPaMfPMOXi28e+FAi+0Dpvrv0+f5a2onI
 9saQ==
X-Gm-Message-State: APjAAAXCbNR6A4pGrx+vX11yXT499EEaLlgbrkQwf5PsJkPAz75n8dXZ
 0lkn/0JPiCQcg0zD8o9w6Iiyrg==
X-Google-Smtp-Source: APXvYqxDk0pBWexRk3I3iE1OhD3d8wrKS4sKVYdNFtBd0eFceWmcJygG5eS7KMUsd1AWbwgJmjkJ1Q==
X-Received: by 2002:a7b:cc93:: with SMTP id p19mr8205188wma.12.1562163868593; 
 Wed, 03 Jul 2019 07:24:28 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id a6sm16469wmj.15.2019.07.03.07.24.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 07:24:27 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190703135411.28436-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <43fe3646-1ee5-238e-3f0b-dc0b2e976b6e@redhat.com>
Date: Wed, 3 Jul 2019 16:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703135411.28436-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 3:54 PM, Daniel P. Berrangé wrote:
> A supposed exploit of QEMU was recently announced as CVE-2019-12928
> claiming that the monitor console was insecure because the "migrate"
> comand enabled arbitrary command execution for a remote attacker.
> 
> For this to be a flaw the user launching QEMU must have configured
> the monitor in a way that allows for other userrs to access it. The
> exploit report quoted use of the "tcp" character device backend for
> QMP.
> 
> This would indeed allow any network user to connect to QEMU and
> execute arbitrary comamnds, however, this is not a flaw in QEMU.

comamnds -> commands

> It is the normal expected behaviour of the monitor console and the
> commands it supports. Given a monitor connection, there are many
> ways to access host filesystem content besides the migrate command.
> 
> The reality is that the monitor console (whether QMP or HMP) is
> considered a privileged interface to QEMU and as such must only
> be made available to trusted users. IOW, making it available with
> no authentication over TCP is simply a, very serious, user
> configuration error not a security flaw in QEMU itself.
> 
> The one thing this bogus security report highlights though is that
> we have not clearly documented the security implications around the
> use of the monitor. Add a few paragraphs of text to the security
> docs explaining why the monitor is a privileged interface and making
> a recommendation to only use the UNIX socket character device backend.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/docs/security.texi b/docs/security.texi
> index 927764f1e6..5bff01449d 100644
> --- a/docs/security.texi
> +++ b/docs/security.texi
> @@ -129,3 +129,39 @@ those resources that were granted to it.
>  system calls that are not needed by QEMU, thereby reducing the host kernel
>  attack surface.
>  @end itemize
> +
> +@section Sensitive configurations
> +
> +There are aspects of QEMU that can have non-obvious security implications
> +which users & management applications must be aware of.
> +
> +@subsection Monitor console (QMP and HMP)
> +
> +The monitor console (whether used with QMP or HMP) provides an RPC interface
> +to dynamically control many aspects of QEMU's runtime operation. Many of the
> +commands exposed will instruct QEMU to access content on the host filesysystem
> +and/or trigger spawning of external processes.
> +
> +For example, the @code{migrate} command allows for the spawning of arbitrary
> +processes for the purpose of tunnelling the migration data stream. The
> +@code{blockdev-add} command instructs QEMU to open arbitrary files, exposing
> +their content to the guest as a virtual disk.
> +
> +Unless QEMU is otherwise confined using technologies such as SELinux, AppArmor,
> +or Linux namespaces, the monitor console should be considered to have privileges
> +equivalent to those of the user account QEMU is running under.
> +
> +It is further important to consider the security of the character device backend
> +over which the monitor console is exposed. It needs to have protection against
> +malicious third parties which might try to make unauthorized connections, or
> +perform man-in-the-middle attacks. Many of the character device backends do not
> +satisfy this requirement and so must not be used for the monitor console.
> +
> +The general recommendation is that the monitor console should be exposed over
> +a UNIX domain socket backend to the local host only. Use of the TCP based
> +character device backend is inappropriate unless configured to use both TLS
> +encryption and authorization control policy on client connections.
> +
> +In summary the monitor console is considered a privileged control interface to

I'd have written "In summary, " or "In summary: " but I'm not sure this
is correct/better ;)

> +QEMU and as such should only be made accessible to a trusted management
> +application or user.
> 

Thanks for writing this down.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

