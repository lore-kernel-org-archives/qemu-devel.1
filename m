Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8363AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526DD2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="qazKv1F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526DD2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihls-0000wd-He
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hihUB-0006nD-Fd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hihUA-00042l-9s
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:55 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:33600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hihU9-00040T-CY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:54 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0283796F56;
 Wed,  3 Jul 2019 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1562168869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdUxgjlyj6iP1cvFB8DvLmro9uPaEQgHOndAn0lPjgc=;
 b=qazKv1F9b4aoe/iKPo0agaRRlnnUq+rluamlUfIQGmZTByYgNhJwWESwd9SJh+B1RvuqTl
 ShsvtHXlXX3o6mxS8QdBnbzO3tdcV/I6bwM0VmnNeUqbdq8V5tQJ9RvvqOA5OgCLz+qdbx
 /wk6klbQG5nishDezTscjTqwnj5KEHE=
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
 <20190701083710.GA18173@stefanha-x1.localdomain>
 <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
 <20190703092946.GC11844@stefanha-x1.localdomain>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <601ba4fe-136d-05fb-1823-6b0f13156fe6@greensocs.com>
Date: Wed, 3 Jul 2019 17:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703092946.GC11844@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1562168869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdUxgjlyj6iP1cvFB8DvLmro9uPaEQgHOndAn0lPjgc=;
 b=6KZgBC1KEBfBc9bjqeMwpQhRUB7HbrPVAb9vB2CvVh/HaiYFTvbAxy9Mb/XDXzjzTsMz7Q
 I0WeCaC7j9TOYySo2L89E70JmEBjYm9lezRpoF+k56OOcczY1fXZcR2ZMkaaQekH8fGwQa
 2OtAayHuNupItIEfVOpxhmtxrFe+WYE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1562168869; a=rsa-sha256; cv=none;
 b=sJwssy+ZYZPjtNePuI8DSNxp9TLjVs4vMMJKJt0V2HqKTY0Dp7+SY6TUqmukHtyCK8ay4k
 pI4eI3ZJey+Dpz3e20jOoWm8tAGkD3hRlsG8S6Tr4tc0cKSF2mWR+7RetU9i7Xr8aDZyCv
 Zv431SlMB9x78039kLdgATrVGDPWgSw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: ehabkost@redhat.com, sakisp@xilinx.com, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, armbru@redhat.com, edgari@xilinx.com, crosa@redhat.com,
 pbonzini@redhat.com, luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 11:29 AM, Stefan Hajnoczi wrote:
> On Mon, Jul 01, 2019 at 12:16:44PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> On 7/1/19 10:37 AM, Stefan Hajnoczi wrote:
>>> On Fri, Jun 28, 2019 at 02:45:29PM +0200, Damien Hedde wrote:
>>>> This series adds a python framework aiming to provide some ways to d=
o fault
>>>> injection in a running vm. In its current state, it allows to easily=
 interact
>>>> with memory, change gpios and qom properties.
>>>>
>>>> The framework consists in a python script based on the qmp existing =
module
>>>> which allows to interact with the vm.
>>>
>>> How does this compare to qtest?  There seems to be a lot of overlap
>>> between them.
>>>
>>> Why is it called "fault injection"?  The commands seem to be
>>> general-purpose device testing functions (like qtest and libqos), not
>>> functions for testing error code paths as would be expected from a fa=
ult
>>> injection framework.
>>
>> I understand qtest is to test QEMU, while this framework/command is to
>> test how the guest react to an hardware faults.
>=20
> The commands seems to be equivalent to qtest commands, just implemented
> as QMP commands.
>=20
> Damien: Can you explain the use case more and show some example test
> cases?

The goal is to test and validate the software running on the vp. We want
to generate some fault to test if the software behave correctly. We
target corner cases that do not happen otherwise on the vp. Basically we
would like, using some scripts, to run some specific scenarios and check
that the expected behavior happens.

Regarding qtest, I was not aware that it provided such commands. I'm
sorry I've missed that. Just checked after reading your feedback,
commands seem indeed equivalent. I don't know if running the vp with
qtest enabled has some hidden drawbacks. But if that's not the case, we
can work to extend the existing qtest commands (or switch some of them
to QMP like Philippe proposed, I don't know what's best).

>=20
>> To use the qtest_mem commands you need to run QEMU with the qtest
>> chardev backend, while this series expose a QMP interface.
>>
>> To avoid the overlap, a cleaner follow up might be to have qtest wrap
>> these QMP commands (mostly like HMP commands do).
>>
>> Another note while looking at a glance, qtest uses the 1st cpu address
>> space view, this series allow to select a specific cpu.
>>
>> It makes sense to me to be able to select address spaces by name (more
>> generic, not restricted to a cpu view, since one might want to inject
>> fault in a device ram not always mapped to a cpu: dma, emac desc).

Good point.

>=20
> The naming issue still stands: none of the commands actually perform
> fault injection.  They can be used for other types of testing or even
> non-testing purposes.
>=20
> Fault injection commands would be "make the next watchdog expiry fail",
> "return error code X on the next DMA request", "report an AHCI link
> failure", etc.
>=20
> These commands are lower-level.  Therefore, I think "fault injection
> framework" is a misnomer and will age poorly if this API is extended in
> the future.

The only fault injection naming was for the python module. I suppose
that if we just extend qtest, there is no need for a new module or
documentation file.

Thanks,

Damien

