Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23633C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D412084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D412084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE9Bd-0005SV-4d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE9At-0004zP-EU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:42:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE9Ar-00068H-5n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:42:30 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-iq_xAhY7MZqN4xNY97gAnQ-1; Fri, 04 Sep 2020 06:42:26 -0400
X-MC-Unique: iq_xAhY7MZqN4xNY97gAnQ-1
Received: by mail-wr1-f72.google.com with SMTP id v12so2185870wrm.9
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 03:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=x8Tbw53cYVTfRZiQaYfMnjqWsbGiSiGpzuUjLzYGfro=;
 b=gpR0TdGtM84jWqbKLXqRbFz8SPbX5yxUUj7WCcozGJrn1STcKAx3SJClCFAZ7oTcdB
 32GNk7EPzjSYA2TuQR3qRBTpJxsti9a/z+JbC0/oxn1Qg/2i60LiLF7zZ77sb/+u9KHH
 7CnC7uN0bxjec2feXtovgQR4A5mQ6uGY+25kR/vjSuxSb5t8AyDczAKnA8S1aegNmpcQ
 /CisV298yKVdFoyPc+wa8VNKLXGYQBR68GO+107PBWVXmxVQhLl0SZJFmPezVJBCjiAl
 NdbWxS/vtANEpkm4/wz4mLnAwjT6GF7YJahLsd8Uo7W/FrMzehwPy+yhwmf6G9KIhGII
 8E4Q==
X-Gm-Message-State: AOAM531UD9m0CeefHOARWwxJ7agzLZYYvOiFVRuth7NZzFa2SfLYviUD
 L0RRiqzNT/ms5MtMjVG1/ACVPHM3T/qYCzRwfRpoHoPSGAbM1ZBRf6lxk4d5af4RmkdpPwIfku7
 +993vd6WpCzyHL/s=
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr6568219wml.147.1599216145120; 
 Fri, 04 Sep 2020 03:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7brbyb53c8CXS8UYrNdR+00+Iz2fChpehK+fxo2gCZv2GnMMEYak3qTGQSxlCy2PQ3/48zg==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr6568177wml.147.1599216144581; 
 Fri, 04 Sep 2020 03:42:24 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h185sm10714596wme.25.2020.09.04.03.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 03:42:23 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] colo: Introduce resource agent and test suite/CI
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <cover.1596536719.git.lukasstraub2@web.de>
 <20200818142701.6d1d82bd@luklap> <20200827104054.45a116fb@luklap>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <244bdfd0-a780-faca-5f7a-b6e103789341@redhat.com>
Date: Fri, 4 Sep 2020 12:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827104054.45a116fb@luklap>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Wainer,

As Cleber is busy with Gating CI, can you
review tests/acceptance/colo.py please?

On 8/27/20 10:40 AM, Lukas Straub wrote:
> On Tue, 18 Aug 2020 14:27:01 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
> 
>> On Tue, 4 Aug 2020 12:46:29 +0200
>> Lukas Straub <lukasstraub2@web.de> wrote:
>>
>>> Hello Everyone,
>>> So here is v3. Patch 1 can already be merged independently of the others.
>>> Please review.
>>>
>>> Regards,
>>> Lukas Straub
>>>
>>> Based-on: <cover.1596528468.git.lukasstraub2@web.de>
>>> "Introduce 'yank' oob qmp command to recover from hanging qemu"
>>>
>>> Changes:
>>>
>>> v3:
>>>  -resource-agent: Don't determine local qemu state by remote master-score, query
>>>   directly via qmp instead
>>>  -resource-agent: Add max_queue_size parameter for colo-compare
>>>  -resource-agent: Fix monitor action on secondary returning error during
>>>   clean shutdown
>>>  -resource-agent: Fix stop action setting master-score to 0 on primary on
>>>   clean shutdown
>>>
>>> v2:
>>>  -use new yank api
>>>  -drop disk_size parameter
>>>  -introduce pick_qemu_util function and use it
>>>
>>> Overview:
>>>
>>> Hello Everyone,
>>> These patches introduce a resource agent for fully automatic management of colo
>>> and a test suite building upon the resource agent to extensively test colo.
>>>
>>> Test suite features:
>>> -Tests failover with peer crashing and hanging and failover during checkpoint
>>> -Tests network using ssh and iperf3
>>> -Quick test requires no special configuration
>>> -Network test for testing colo-compare
>>> -Stress test: failover all the time with network load
>>>
>>> Resource agent features:
>>> -Fully automatic management of colo
>>> -Handles many failures: hanging/crashing qemu, replication error, disk error, ...
>>> -Recovers from hanging qemu by using the "yank" oob command
>>> -Tracks which node has up-to-date data
>>> -Works well in clusters with more than 2 nodes
>>>
>>> Run times on my laptop:
>>> Quick test: 200s
>>> Network test: 800s (tagged as slow)
>>> Stress test: 1300s (tagged as slow)
>>>
>>> For the last two tests, the test suite needs access to a network bridge to
>>> properly test the network, so some parameters need to be given to the test
>>> run. See tests/acceptance/colo.py for more information.
>>>
>>> Regards,
>>> Lukas Straub
>>>
>>> Lukas Straub (7):
>>>   block/quorum.c: stable children names
>>>   avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
>>>   boot_linux.py: Use pick_qemu_util
>>>   colo: Introduce resource agent
>>>   colo: Introduce high-level test suite
>>>   configure,Makefile: Install colo resource-agent
>>>   MAINTAINERS: Add myself as maintainer for COLO resource agent
>>>
>>>  MAINTAINERS                               |    6 +
>>>  Makefile                                  |    5 +
>>>  block/quorum.c                            |   20 +-
>>>  configure                                 |   10 +
>>>  scripts/colo-resource-agent/colo          | 1501 +++++++++++++++++++++
>>>  scripts/colo-resource-agent/crm_master    |   44 +
>>>  scripts/colo-resource-agent/crm_resource  |   12 +
>>>  tests/acceptance/avocado_qemu/__init__.py |   15 +
>>>  tests/acceptance/boot_linux.py            |   11 +-
>>>  tests/acceptance/colo.py                  |  677 ++++++++++
>>>  10 files changed, 2286 insertions(+), 15 deletions(-)
>>>  create mode 100755 scripts/colo-resource-agent/colo
>>>  create mode 100755 scripts/colo-resource-agent/crm_master
>>>  create mode 100755 scripts/colo-resource-agent/crm_resource
>>>  create mode 100644 tests/acceptance/colo.py
>>>
>>> --
>>> 2.20.1  
>>
>> Ping...
> 
> Ping 2...
> 
> Kevin, can you already apply patch 1 "block/quorum.c: stable children names"? It resolves the following bug: https://bugs.launchpad.net/qemu/+bug/1881231
> 
> Regards,
> Lukas Straub
> 


