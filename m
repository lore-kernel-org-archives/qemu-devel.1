Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D42EC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6838B2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CorAcyh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6838B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieN73-00088Q-G0
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ieN5r-0007Ri-Hl
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ieN5o-0003ZO-AH
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:45:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ieN5n-0003Y0-S2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575913506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUslDXrIUkr6EtMIUfOtm0m6oOlTCFbTyDeTHjvvFmA=;
 b=CorAcyh6L4ahcT2XMtuNM+ZTDmNaewXJ5Dvc4V7n2j6eu+VbQrjbXyr0xeqQSpUaATjdCT
 Z9v6ElagGOHbEZ8mKbnxoST549usS5DHVr3REjMLyw1ElP60MOx8eBtWCnKO/gijd9B9p4
 r2Af0TfL0hQ6nY50c9mVn1UV3Bo4MO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-FW1fMXeuMAWSa34DF1-wEw-1; Mon, 09 Dec 2019 12:45:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880C2800D41
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-84.gru2.redhat.com
 [10.97.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82ACC66834;
 Mon,  9 Dec 2019 17:44:59 +0000 (UTC)
Subject: Re: [PATCH 0/2] tests/acceptance: Use QEMUMachine on tests that
 expect failure
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
References: <20191112135801.854-1-wainersm@redhat.com>
Message-ID: <0315ccd0-0b00-fbd9-aadb-7cb9f26fadcd@redhat.com>
Date: Mon, 9 Dec 2019 15:44:56 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191112135801.854-1-wainersm@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FW1fMXeuMAWSa34DF1-wEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

Any brave soul to review it? :)

- Wainer


On 11/12/19 11:57 AM, Wainer dos Santos Moschetta wrote:
> The linux_initrd and empty_cpu_model tests assert that QEMU exit
> with failure on certain scenarios. Currently they are not able
> to use QEMUMachine object due to the QMP monitor connection which
> is tentatively established always. Instead they handle the QEMU binary
> directy, but ideally they should use QEMUMachine in order to:
>   a) Take advantage of error handling and logging in QEMUMachine.
>   b) Follow the pattern in other acceptance tests.
>
> Notes worth it:
>   - Patch 01 first appeared in [1]. Here I propose the same
>     implementation but the code was rebased.
>   - empty_cpu_model used to check both stdout and stderr of the process. The
>     QEMUMachine doesn't provide an interface to access the underneath
>     process object, instead the process' output is available through
>     get_log(). This method in turn returns the content of stdout (stderr is
>     redirected to stdout). Therefore, I adapted the assertion statement
>     to check the '-cpu option cannot be empty' message shows in the output.
>
> Git:
>   - Tree: https://github.com/wainersm/qemu
>   - Branch: tests_without_qmp
>
> CI:
>   - Travis (PASS): https://travis-ci.org/wainersm/qemu/builds/610499693
>
> References:
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html
>
> Wainer dos Santos Moschetta (2):
>    python/qemu: Add set_qmp_monitor() to QEMUMachine
>    tests/acceptance: Makes linux_initrd and empty_cpu_model use
>      QEMUMachine
>
>   python/qemu/machine.py              | 68 +++++++++++++++++++----------
>   tests/acceptance/empty_cpu_model.py | 13 +++---
>   tests/acceptance/linux_initrd.py    | 13 +++---
>   3 files changed, 59 insertions(+), 35 deletions(-)
>


