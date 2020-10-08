Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0658C4742A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B83221924
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzRLMZnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B83221924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXuS-0000Z3-6t
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQXrk-0007Mo-MM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQXrh-0007gN-E5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602170995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQ8sm2mYvVISSW4jor5K0+hdVwjfXONObASI7JBl3HM=;
 b=UzRLMZnLtye4COKe0M1UabtTRs+RoJt1fNdXai0GbxqeQ/NWe+rAdHb1Ocok4dvEl85ASk
 33L/ENYh09lqp+a5geCZnAlsHYdvPgl6J4Fl+GQ7JwjM91w1CdAp+nJ/8+y8jnxzzYsJv4
 GT9Y7INr55UYmpNHAdO8w/d4KxUdR+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-mQwuorrZOyCvsOXSQWl0cg-1; Thu, 08 Oct 2020 11:29:53 -0400
X-MC-Unique: mQwuorrZOyCvsOXSQWl0cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD321091074;
 Thu,  8 Oct 2020 15:29:52 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3A0510013C1;
 Thu,  8 Oct 2020 15:29:51 +0000 (UTC)
Subject: Re: [PATCH 00/20] python/qemu: strictly typed mypy conversion, pt2
To: qemu-devel@nongnu.org
References: <20201006235817.3280413-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ad934512-a97d-1c87-9986-ebce94473d25@redhat.com>
Date: Thu, 8 Oct 2020 11:29:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 7:57 PM, John Snow wrote:
> Continuing where I left off prior to the 5.1 release, this series
> touches up a few odds and ends and introduces mypy hints.
> 
> What's new:
> 
> - Using isort to solidify import order
> - Patches adding small corrections and typing for console_socket
> - A few error class changes for qmp.py
> 
> Like my QAPI series, this requires:
> 
> - pylint >= 2.6.0
> - flake8 >= 3.8.0
> - mypy >= 0.770
> - isort >= 4.3.0 (Presumably...)
> 
> What this series doesn't do:
> 
> - Create a proper python package
> - Establish a CI test to prevent regressions
> - Fix the docstring conventions in the library
> 
> Those are coming soon! (and in the order mentioned.)
> 
> Changes against the last version of this series that was sent prior to
> 5.1:
> 
> 001/20:[down] 'python/qemu: use isort to lay out imports'
> 002/20:[0005] [FC] 'python/machine.py: Fix monitor address typing'
> 003/20:[0015] [FC] 'python/machine.py: reorder __init__'
> 004/20:[0009] [FC] 'python/machine.py: Don't modify state in _base_args()'
> 005/20:[0002] [FC] 'python/machine.py: Handle None events in events_wait'
> 006/20:[0006] [FC] 'python/machine.py: use qmp.command'
> 007/20:[----] [-C] 'python/machine.py: Add _qmp access shim'
> 008/20:[----] [-C] 'python/machine.py: fix _popen access'
> 009/20:[0006] [FC] 'python/qemu: make 'args' style arguments immutable'
> 010/20:[----] [--] 'iotests.py: Adjust HMP kwargs typing'
> 011/20:[0010] [FC] 'python/qemu: Add mypy type annotations'
> 012/20:[down] 'python/qemu/console_socket.py: Correct type of recv()'
> 013/20:[down] 'python/qemu/console_socket.py: fix typing of settimeout'
> 014/20:[down] 'python/qemu/console_socket.py: Clarify type of drain_thread'
> 015/20:[down] 'python/qemu/console_socket.py: Add type hint annotations'
> 016/20:[down] 'python/console_socket: avoid encoding to/from string'
> 017/20:[down] 'python/qemu/qmp.py: Preserve error context on re-raise'
> 018/20:[down] 'python/qemu/qmp.py: re-raise OSError when encountered'
> 019/20:[down] 'python/qemu/qmp.py: Straighten out exception hierarchy'
> 020/20:[down] 'python: add mypy config'
> 
> 02: import order differences, context changes from console_socket.py
> 03: (minor) changes for console_socket, RB-s dropped just in case
> 04: import order differences
> 05: import order differences
> 06: import order differences
> 09: import order differences
> 11: import order differences, small changes for console_socket
> 
> John Snow (20):
>    python/qemu: use isort to lay out imports
>    python/machine.py: Fix monitor address typing
>    python/machine.py: reorder __init__
>    python/machine.py: Don't modify state in _base_args()
>    python/machine.py: Handle None events in events_wait
>    python/machine.py: use qmp.command
>    python/machine.py: Add _qmp access shim
>    python/machine.py: fix _popen access
>    python/qemu: make 'args' style arguments immutable
>    iotests.py: Adjust HMP kwargs typing
>    python/qemu: Add mypy type annotations
>    python/qemu/console_socket.py: Correct type of recv()
>    python/qemu/console_socket.py: fix typing of settimeout
>    python/qemu/console_socket.py: Clarify type of drain_thread
>    python/qemu/console_socket.py: Add type hint annotations
>    python/console_socket: avoid encoding to/from string
>    python/qemu/qmp.py: Preserve error context on re-raise
>    python/qemu/qmp.py: re-raise OSError when encountered
>    python/qemu/qmp.py: Straighten out exception hierarchy
>    python: add mypy config
> 
>   python/mypy.ini               |   4 +
>   python/qemu/.isort.cfg        |   7 +
>   python/qemu/accel.py          |   9 +-
>   python/qemu/console_socket.py |  54 +++---
>   python/qemu/machine.py        | 306 +++++++++++++++++++++-------------
>   python/qemu/qmp.py            | 114 ++++++++-----
>   python/qemu/qtest.py          |  55 +++---
>   tests/qemu-iotests/iotests.py |   2 +-
>   8 files changed, 331 insertions(+), 220 deletions(-)
>   create mode 100644 python/mypy.ini
>   create mode 100644 python/qemu/.isort.cfg
> 

Thanks, I am staging patches 1-17 -- alongside the Python maintainers 
patch I have been kicking around -- to my python branch.

Cleaning up the error classes in 18-19 is looking more fiddly, so I'm 
spinning it out into a new small series for better review.

https://gitlab.com/jsnow/qemu.git python
https://gitlab.com/jsnow/qemu/-/tree/python

--js


