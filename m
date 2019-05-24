Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE86C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E57220862
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E57220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9I9-0004JC-DY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:27:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9Gk-0003NV-Ty
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9Gg-0003NS-QB
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hU9Gg-0003M4-FA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:25:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A4653179170;
	Fri, 24 May 2019 12:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA86A5DA2E;
	Fri, 24 May 2019 12:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5473C1138648; Fri, 24 May 2019 14:25:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-7-armbru@redhat.com>
	<CAFEAcA_b-rPUuDF_A2Q112-aJEqfSA17kJjD3W0aKaOOP7-hjA@mail.gmail.com>
Date: Fri, 24 May 2019 14:25:46 +0200
In-Reply-To: <CAFEAcA_b-rPUuDF_A2Q112-aJEqfSA17kJjD3W0aKaOOP7-hjA@mail.gmail.com>
	(Peter Maydell's message of "Fri, 24 May 2019 10:11:12 +0100")
Message-ID: <87ftp49gz9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 24 May 2019 12:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 6/7] tests: Don't limit check-headers to
 include/
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 23 May 2019 at 09:15, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>  432 files changed, 1035 insertions(+), 8 deletions(-)
>>
>> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
>> index 685602b076..352da0c745 100644
>> --- a/accel/tcg/atomic_template.h
>> +++ b/accel/tcg/atomic_template.h
>> @@ -18,6 +18,9 @@
>>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>   */
>>
>> +/* NOTE: May only be included into target-dependent code */
>> +/* FIXME Does not pass make check-headers, yet! */
>> +
>
> I'm not sure I see much point in touching several hundred
> header files just to add a FIXME note. We can fix them,
> or we can just leave things as they are...

Adding FIXMEs without an intent to actually fix them would be stupid.

The FIXMEs direct "make check-headers" to skip the headers so marked.
Without the FIXMEs, "make check-headers" fails.  I want it to succeed,
so we can run it from "make check", and gain protection against clean
headers becoming unclean.

What "make check-headers" covers is for us to choose.  This RFC series
starts with include/, then widens to everything in two big steps:

* PATCH 5: include/.  764 headers, 179 known-bad.

* PATCH 6: all of the source tree.  Adds 797 headers, 409 known-bad.

* PATCH 7: plus generated headers.  Adds 177 headers, 3 known-bad.

We can start smaller, and take smaller steps.

