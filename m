Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03875C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409EC2078A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlyIBwQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409EC2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRru-0003eF-AB
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPRrK-0003CP-1L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPRrH-0007bw-B1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601909577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4W+3vC98JIRH0dFZ2lDBA+GR9nlk6eHq2We2sQDZw4=;
 b=AlyIBwQ7u4Y2x2WQYySIgaZyW/KuUz031FxmXErCn/AFV2FIW7vRbkt+VHatAo4ZUMEGIk
 RRTRBJ3QY2+MiIUrnWa7V7JxYXpn4uS6MQqzbrDVrckBR47t5wIfQAsnHn6iO6nE5BOnbg
 1DGqaDpUYpI0hXqC7I19M3tG1+oHzck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-Cvz60RqUOJCDlLJwf6C27A-1; Mon, 05 Oct 2020 10:52:54 -0400
X-MC-Unique: Cvz60RqUOJCDlLJwf6C27A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50A5218BE162;
 Mon,  5 Oct 2020 14:52:53 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 843455C22B;
 Mon,  5 Oct 2020 14:52:42 +0000 (UTC)
Subject: Re: QEMU API cleanup initiative - Let's chat during the KVM call
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <1f0b0576-eb07-bf5a-a4d8-c6a2d18d1a94@redhat.com>
 <20201005134552.GC5029@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <8e8a7b4d-e3a8-efe0-47b0-d20186970cee@redhat.com>
Date: Mon, 5 Oct 2020 10:52:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005134552.GC5029@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:45 AM, Stefan Hajnoczi wrote:
> On Sat, Oct 03, 2020 at 08:14:11PM -0400, John Snow wrote:
>> I would like to use the KVM call to discuss a roadmap for converting the
>> remaining options to QAPI, what that would take, and who will take ownership
>> for which subsystems/flags. I would like to bring these discussions to KVM
>> Forum and lend serious, dedicated effort to finishing this task.
> 
> Subsystem maintainers will need to review these patches. Hopefully many
> of them are willing to do the conversion themselves. Code examples for
> common conversions would help (e.g. QemuOpts to QAPI, strtol() to QAPI,
> etc).
> 

Yes, and this depends on how far exactly we want to go on our first 
conversion pass. The exact point we pick as our first intermediate step 
might determine these common conversions.

QemuOpts might be a reasonable first step, or maybe we want to go all 
the way straight to QAPI.

In a few cases (like -cpu), we probably want to start normalizing the 
way in which models are lookup up and defined; some architectures allow 
you to lowercase the models, or perform other text mapping conversions.

We could start deprecating / standardizing these transformations to try 
and unify the CPU parsing infrastructure which would give us a chance to 
describe it all with one set of rules.

Some of this depends on Markus's existing patches -- He has a series 
from 2018 (IIRC) that attempts a lot of the low-hanging fruit for this 
work, and that might serve as a reasonable basis.

Things to discuss.

> Do error messages need to be preserved? For example, maybe the input
> validation order or the actual error message is different with QAPI and
> that may affect programs that launch QEMU.
> 

It's a good point to talk about.

- Markus considers the platonic ideal of a CLI one in which each flag is 
a configuration directive, and each directive that references another 
directive must appear after the directive in which it references.

- I tend to consider the ideal configuration to be a static object that 
has no inherent order from one key to the next, e.g. a JSON object or 
static flat file that can be used to configure the sysemu.

They're not compatible visions; and they have implications for error 
ordering and messages and so on.

For the meantime, Markus's vision is closer to what QEMU already does, 
so it's likely the winning answer for now and if a conversion to the 
other idea is required at a time later, we'll have to tackle it then. (I 
think.)

It's a good subject of discussion. (Also relevant: if parsing is to 
occur in more than the CLI context, the existing contextual CLI parser 
error system needs to be reworked to avoid monitor-unsafe error calls. 
It's not trivial, I think.)

> Is there any way to detect incompatible command-line changes besides
> running make check? One idea is to run a fuzzer to check if certain
> inputs are accepted by the new/old version but not the other.
> 

That might be interesting. I did some fairly thorough auditing to 
understand what each flag actually accepts at-present, but I don't have 
good experience with any fuzzer such to be able to model that exactly.

I'd be happy to hear about ways we could try to model this. Possibly 
intentionally deprecating things to reduce the size of some of our 
weirder parsers might help the modeling effort, too.

> Stefan
> 

--js


