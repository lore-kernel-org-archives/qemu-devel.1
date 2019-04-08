Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB0FC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B54020880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 06:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B54020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDNMe-0004ic-EX
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 02:02:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNLO-00044p-4c
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNLN-0000kP-4D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDNLM-0000jl-Sl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24DDD8AE41
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 06:01:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 876D460471;
	Mon,  8 Apr 2019 06:01:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EA1C01138648; Mon,  8 Apr 2019 08:01:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
	<3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
	<fda6bc0b-9ea0-2770-f104-568b3f16ab90@redhat.com>
	<265f98b8-675c-99fb-0ef8-0dcc13c14a91@redhat.com>
	<02729d68-9714-141b-b221-74ff31dca977@redhat.com>
Date: Mon, 08 Apr 2019 08:01:13 +0200
In-Reply-To: <02729d68-9714-141b-b221-74ff31dca977@redhat.com> (Paolo
	Bonzini's message of "Fri, 5 Apr 2019 09:58:21 +0200")
Message-ID: <87ef6djas6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 08 Apr 2019 06:01:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
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
Cc: Thomas Huth <thuth@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408060113.mQNCEwpJlKgyLbUjf7stHfmkBbb2Z7UUPiCgkuUP5Ds@z>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/04/19 22:49, Philippe Mathieu-Daud=C3=A9 wrote:
>> While I wonder if someone still use the r4k machine, I have more doubts
>> about users running with more the 2 -serial options...
>
> I sort of remember ISA extension cards that had jumpers or dip switches
> to choose between COM1/COM2/COM3/COM4...

They still exist, with I/O ports and IRQ lines selectable via jumpers &
DIP switches.  Traditionally:

    COM1: I/O port 0x3F8, IRQ 4
    COM2: I/O port 0x2F8, IRQ 3
    COM3: I/O port 0x3E8, IRQ 4
    COM4: I/O port 0x2E8, IRQ 3

