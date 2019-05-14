Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33701C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094B920862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094B920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa3O-0004Wi-QY
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:13:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQZu7-0005xq-5H
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQZu5-0001XH-VE
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:03:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQZu5-0001Tb-Od
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:03:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so3387931wru.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4thk9JnFvY2YMx/BKLOt0TrFs1IXjpBBxhkF2KqFGoo=;
	b=chGJ8u0+2ZNSU2kH46AHy0SZTkOlf05Lf3rV3erjcv6/eziN6HwHCpXCu7JzSs666v
	fQYztvJDuMytuhMckHrrJXzNsqwzBkFLDsxeNeF+Lay8RsG+exNI+XKXcEouJw3mDPAh
	/NXGJRhGYcm8dH4ofBETJVHtfS+iTKZXcV1ZZF7E9ytYH6A13b+qoxe3tT8yVNfpiVLq
	7qXCVWrVKFVfFo5kzxELIVb+KfyX6bwg/PNOfp8QekScnvBvH6uNvx5VuqDrfDSMvdwx
	/nf3oGDDra+9EzunKZF52KNaDbZ+RtENrX8CoI2xcMD2ZaJnpb8pmpqjsipav1amK+ck
	AfBQ==
X-Gm-Message-State: APjAAAX5CH1KFhc+4Wdu8nDzpFN7KnjR1qwQ9I7tnSjiJRw6ho9gLOOj
	iMbfEwRosyHz7BkPB3xKmEJUXw==
X-Google-Smtp-Source: APXvYqxhPL9Rg0GCgei3f1Ce7wHjVme4h+/TtmFOE4El5mMXkwtxpNmtgOuEBrWtcyU/FkrOf/shlQ==
X-Received: by 2002:adf:b612:: with SMTP id f18mr21821655wre.236.1557849822084;
	Tue, 14 May 2019 09:03:42 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id s2sm1989926wmc.7.2019.05.14.09.03.41
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:03:41 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a2192d30-6775-adec-2e8a-08526727271e@redhat.com>
Date: Tue, 14 May 2019 18:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877eat6xgm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 2:18 PM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> wrote:
>>> Perhaps I should do it just for this file while I touch it anyway.  The
>>> question to ask: should parse_acl_file() obey the locale for whitespace
>>> recognition?
>>
>> I vote for "no".
>>
>> Q: do we document the format of the ACL file anywhere ?
> 
> Support for it was added in commit bdef79a2994, v1.1.  Just code, no
> documentation.
> 
> Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contains
> -help output and some .texi that goes into qemu-doc and the manual page.
> None of it mentions how qemu-bridge-helper is run, or the ACL file
> feature, let alone what its format might be.
> 
> I'm afraid all we have is the commit message.  Which doesn't really
> define the file format, it merely gives a bunch of examples.
> 
> As far as I can tell, qemu-bridge-helper is for use with -netdev tap and
> -netdev bridge.
> 
> Both variations of -netdev call net_bridge_run_helper() to run the
> helper.  First argument is -netdev parameter "helper", default usually
> "$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
> "br", default "br0".
> 
> If @helper contains space or tab, net_bridge_run_helper() guesses its a
> full command, else it guesses its the name of the executable.  Bad
> magic.
> 
> If it guesses name of executable, it execv()s this executable with
> arguments "--use-vnet", "--fd=FD", "--br=@bridge".
> 
> If it guesses full command, it appends "--use-vnet --fd=FD", where FD is
> the helper's half of the socketpair used to connect QEMU and the helper.
> It further appends "--br=@bridge", unless @helper contains "--br=".
> More bad magic.
> 
> It executes the resulting string with sh -c.  Magic cherry on top.
> 
> When the helper fails, netdev creation fails.
> 
> The helper we ship with QEMU unconditionally tries to read
> "$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
> Errors in this file are fatal.  Errors in files it includes are not
> fatal; instead, the remainder of the erroneous file is ignored.
> *Boggle*
> 
> As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo's
> commit 2d80fbb14df).  Makes sense, because running QEMU with the
> necessary privileges would be unwise, and so would be letting it execute
> setuid helpers.  Also bypasses the bad magic in QEMU's
> net_bridge_run_helper().
> 
> qemu-bridge-helper should have a manual page, and its handling of errors
> in ACL include files needs work.  There's probably more; I just glanced
> at it.  I'm not volunteering, though.  It lacks a maintainer.  Should we
> add it to Jason's "Network device backends"?
> 
> -netdev's helper parameter is seriously underdocumented.  Document or
> deprecate?
> 

I understood the project policy is "deprecate until maintained or
tested"... If not, we might start to think about it :)

