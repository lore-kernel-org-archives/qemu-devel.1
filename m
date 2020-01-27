Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACBCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FB9214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqyqlhmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FB9214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9Lf-0005fi-GR
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw9Ky-0005Gy-8V
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw9Kv-0002x5-Jm
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:42:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw9Kv-0002wE-9o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580150532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojO5w1TfYR50HRXN//XFhAxRZpoT/j35wgIOAHCecmg=;
 b=MqyqlhmXujiqPuNmr932fTZPIrlgMRfroVoxcWetUMYQTyJom84lKV8J7T0xBH8YgyYoZ6
 bXxiZKysY7JtOPxnFkY4vYLNeG97QP9pjN6A+AM0xq16iUAaUV7d1I65i1fNP0DbbvTzAw
 ItLxt7cv3/1ohFeAC1sIBM6PXEvsEzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-5t5ziRUmMbeaPKz--g_b5w-1; Mon, 27 Jan 2020 13:42:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA6A13E3;
 Mon, 27 Jan 2020 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D7D53B7;
 Mon, 27 Jan 2020 18:42:05 +0000 (UTC)
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b70dd597-40ee-ff39-3057-72c398c5c4a9@redhat.com>
Date: Mon, 27 Jan 2020 16:42:04 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5t5ziRUmMbeaPKz--g_b5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/21/20 12:07 PM, Aleksandar Markovic wrote:
> On Mon, Jan 20, 2020 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
>>> 3) The community will be given all devised performance measurement methods in the form of easily reproducible step-by-step setup and execution procedures.
>> Tracking performance is a good idea and something that has not been done
>> upstream yet.
> Thanks for the interest, Stefan!
>
>>   A few questions:
>>
>>   * Will benchmarks be run automatically (e.g. nightly or weekly) on
>>     someone's hardware or does every TCG architecture maintainer need to
>>     run them manually for themselves?
> If the community wants it, definitely yes. Once the methodology is
> developed, it should be straightforward to setup nightly and/or weekly
> benchmarks - that could definitely include sending mails with reports
> to the entire list or just individuals or subgroups. The recipient
> choice is just a matter or having decent criteria about
> appropriateness of information within the message (e.g. not to flood
> the list with the data most people are not really interested).
>
> For linux-user tests, they are typically very quick, and nightly tests
> are quite feasible to run. On someone hardware, of course, and
> consistently always on the same hardware, if possible. If it makes
> sense, one could setup multiple test beds with a variety of hardware
> setups.
>
> For system mode tests, I knoe they are much more difficult to
> automate, and, on top of that, there could be greater risk of
> hangs/crashes Also, considering the number of machines we support,
> those tests could consume much more time - perhaps even one day would
> not be sufficient, if we have many machines and boot/shutdown
> variants. For these reason, perhaps weekly executions would be more
> appropriate for them, and, in general, given greater complexity, the
> expectation from system-mode performance tests should be better kept
> quite low for now.
>
>>   * Where will the benchmark result history be stored?
>>
> If emailing is set up, the results could be reconstructed from emails.
> But, yes, it would be better if the result history is kept somewhere
> on an internet-connected file server


If you eventually choose Gitlab CI for weekly/nightly executions then 
results can be simply archived [1].

Also it can be attached machines in Gitlab CI then running the 
system-mode experiment always on same environment.

[1] https://docs.gitlab.com/ee/user/project/pipelines/job_artifacts.html

IMHO, it is a very good GSoC proposal.

- Wainer

>
> Yours,
> Aleksandar
>
>> Stefan


