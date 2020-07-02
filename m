Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E63220899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihn+65Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E63220899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqtvl-0004q2-TX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqtut-0003mS-7Q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:45:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqtur-0006Po-K7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593675953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqXIYaqrP69iIlxsLf6IOdoE/j+Dn+PhnFCdaO9hJC4=;
 b=ihn+65VyAj+wFK862GbuKeYuLd09lMGvh+GRtS1aJviYlEQtqunBCTPXUMKhB/6Y3hnWIH
 JBn0GGQd2cUq5Sw66x5RptiFNLzDpYNApD3h14Eie2x3QYkDAzvThthpE8TuZZD749gpaE
 R5YPmUnRdnZls18baAjl8YJKIeJb94I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-SFCOWpoRM3mUH8A5AWttbg-1; Thu, 02 Jul 2020 03:45:49 -0400
X-MC-Unique: SFCOWpoRM3mUH8A5AWttbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E6019057A2;
 Thu,  2 Jul 2020 07:45:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1DB610F2;
 Thu,  2 Jul 2020 07:45:45 +0000 (UTC)
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630195723.1359-1-f4bug@amsat.org>
 <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
 <20200701173944.GA1090525@aurel32.net>
 <CAHiYmc5Y6_OcjYS8zR=hKGFeeL9zJ2g+CX8jeNyZdyMnH6uO+g@mail.gmail.com>
 <20200701211703.GB1093119@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ddc3ff7e-1582-2e76-2dbb-c60085d41711@redhat.com>
Date: Thu, 2 Jul 2020 09:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200701211703.GB1093119@aurel32.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/2020 23.17, Aurelien Jarno wrote:
> Aleksandar,
> 
> On 2020-07-01 20:51, Aleksandar Markovic wrote:
>> On Wed, Jul 1, 2020 at 7:39 PM Aurelien Jarno <aurelien@aurel32.net> wrote:
>>>
>>> Aleksandar,
>>>
>>> On 2020-06-30 23:54, Aleksandar Markovic wrote:
>>>> As, in a very clear way, evidenced from the previous versions of this
>>>> series, this series real goal was not not to create some new
>>>> "malta-strict" machine, but to prepare path to creation of some
>>>> imagined "malta-unleashed" machine which will, to the contrary of
>>>> proclaimed goal, create a machine that could never exist in reality.
>>>> That is why I can't accept this series.
>>>
>>> I do not understand your opposition to this, and why it is an issue to
>>> support more than 2GiB of RAM for such a board. Supporting more than 2GiB
>>> of memory doesn't prevent people to emulate a real Malta board with less
>>> memory.
>>>
>>> In addition to that, the Malta board in QEMU has been supporting for
>>> many years more than the maximum 256MiB that is possible on a physical
>>> board. The QEMU version also supports way more than CPU variants than
>>> the physical board. In other word the existing malta machine in QEMU is
>>> already a "malta-unleashed".
>>>
>>
>> Aurelien,
>>
>> Glad to see you again. I am really sorry you were absent for so long.
> 
> I assumed that since haven't dramatically changes in QEMU since I left,
> however if I missed some recent discussions that goes again what I am
> saying below, please feel free to point me to them.
> 
>> Those (what you described in the paragraphs above) were mistakes from
>> the past. At some point, we needed to stop doing it, and finally
>> returned to the root QEMU principles of emulating systems as
>> faithfully as possible.
> 
> I think there is a big misunderstanding here. The root QEMU principle is
> to emulate each *device* or *feature* as faithfully as possible. The
> *default* system that is emulated should also match as much as possible
> the real hardware, but QEMU also gives users the possibility to create a
> system as they want. And the amount of memory is one them.  That's
> actually all the beauty of QEMU. Remember that QEMU solely exists
> because it has users, and that the possibility to extend the RAM of the
> Malta board to 2GB and to select various CPUs is widely used by users.
> 
> So overall there are plenty of counter examples to your "root QEMU
> principles". Daniel P. Berrangé mentioned the memory support on the
> i440fx x86 hardware. As other examples you can also add AMD 3D Now
> instructions to an Intel CPU, or add an AC97 sound device to a SH4
> machine. Virtio is another example.

I fully agree with Aurelien and Daniel here. As far as I know, there has 
never been a "root QEMU principle" that says that we have to restrict 
things like RAM sizes to the constraints of real hardware.

Aleksandar, where did you get the idea of that "root QEMU principle" 
from? If it's something that is written in our documentation somewhere, 
it's maybe misleading and needs to be rewritten, so please provide a 
pointer.

  Thanks,
   Thomas


