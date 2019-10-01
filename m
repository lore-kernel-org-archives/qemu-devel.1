Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B68C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419FD2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419FD2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEM5-0002UX-9z
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFEKu-0001CX-Pd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFEKt-0006Tf-5W
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFEKs-0006T2-TK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:20:47 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7FBB2D1CE
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:20:45 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so645973wmg.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j6UXHfItFa0OAUgIF/55ko4z5qkmMhX0rgI7YKD4O5c=;
 b=hbW+j7i/f+zsS0FW4T6q0k1U/+nVzYilLBl9nWsNDmNW01T2jCM/JPEkrGjlguYD+M
 n66GSAES0GQZFjK+rqv9M4ujRyDBDuNRgLbETkRcwPx56W15McnZDM0aVUYMvCf50iYz
 H05wIIdu3MCq/SHtDkeYTgAfDr6Vg8HSLAXB7YDMlSBI7aYmFK1xZAvF9mwCtufw9Bxd
 MEqSB050qeqmTI2oE6KAnqY9Yv9A0X+3jgYny2h3FI0oVS+7EZWicJa5ib1Vl7cJMCAu
 1omrC1CQRgwmhfSzdHl88NnqMsT7OJKoHHnKmivfNuWAYZ4r4s3VhWX8TMxEtmM/NUmN
 ADGw==
X-Gm-Message-State: APjAAAU20ru3XgvrRGeas8Xdroh2n7rvoCQPNUNHmjKTzoIFaqkVliNc
 0uFU/DvmsuPC5nu8CA/oV0rYqIIOBUUs8OXhw3mByle9KpjZD9YUsX9uAksCvfa+l/o3erBrWcW
 CKiOW/zpIFRWv0o8=
X-Received: by 2002:a5d:52cd:: with SMTP id r13mr16088173wrv.376.1569921644497; 
 Tue, 01 Oct 2019 02:20:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuhm8/C+2/CwN1UYuf67MgQQeaByQ48XupRAFjkWA0NkNsIDfEF9rlS8XnS7iyCYp/+Xbc0A==
X-Received: by 2002:a5d:52cd:: with SMTP id r13mr16088143wrv.376.1569921644213; 
 Tue, 01 Oct 2019 02:20:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id d9sm18791001wrf.62.2019.10.01.02.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:20:43 -0700 (PDT)
Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
To: Jiri Denemark <jdenemar@redhat.com>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
 <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
 <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
 <20190930161611.GP4884@orkuz.int.mamuti.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4d94d1d1-746b-dbe4-f705-b33e347f9138@redhat.com>
Date: Tue, 1 Oct 2019 11:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930161611.GP4884@orkuz.int.mamuti.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kang,
 Luwei" <luwei.kang@intel.com>, Robert Hoo <robert.hu@linux.intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Hu, Robert" <robert.hu@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 18:16, Jiri Denemark wrote:
> On Mon, Sep 30, 2019 at 17:16:27 +0200, Paolo Bonzini wrote:
>> On 30/09/19 16:31, Hu, Robert wrote:
>>>> This might be a problem if there are plans to eventually make KVM support
>>>> pconfig, though.  Paolo, Robert, are there plans to support pconfig in KVM in the
>>>> future?
>>> [Robert Hoo] 
>>> Thanks Eduardo for efforts in resolving this issue, introduced from my Icelake CPU
>>> model patch.
>>> I've no idea about PCONFIG's detail and plan. Let me sync with Huang, Kai and answer
>>> you soon.
>>
>> It's really, really unlikely.  It's possible that some future processor
>> overloads PCONFIG in such a way that it will become virtualizable, but
>> not IceLake.
> 
> I guess, the likelihood of this happening would be similar to
> reintroducing other features, such as osxsave or ospke, right?

No, haveing osxsave and ospke was a mistake in the first place (they are
not CPU features at all; they are more like a special way to let
unprivileged programs read some bits of CR4).  For pconfig, it's just
very unlikely.

>> Would it make sense for libvirt to treat absent CPU flags as "default
>> off" during migration, so that it can leave out the flag in the command
>> line if it's off?  If it's on, libvirt would pass pconfig=on as usual.
>> This is a variant of [2], but more generally applicable:
>>
>>> [2] However starting a domain with Icelake-Server so that it can be
>>> migrated or saved/restored on QEMU in 3.1.1 and 4.0.0 would be
>>> impossible. This can be solved by a different hack, which would drop
>>> pconfig=off from QEMU command line.
> 
> The domain XML does not contain a complete list of all CPU features.
> Features which are implicitly included in a CPU model are not listed in
> the XML. Count in the differences in libvirt's vs QEMU's definitions of
> a particular CPU model and you can see feat=off cannot be mechanically
> dropped from the command line as the CPU model itself could turn it on
> by default and thus feat=off is not redundant.

I think I wasn't very clear, I meant "unsupported by QEMU" when I said
"absent".  Libvirt on the destination knows that from
query-cpu-model-expansion, so it can leave off pconfig if it is not
supported by the destination QEMU.

Paolo

