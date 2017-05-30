Received: from eggs.gnu.org ([2001:4830:134:3::10]:50039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dFdwn-0008B6-Ag
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dFdwm-0007FP-Fw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:00:17 -0400
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:33972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dFdwm-0007FI-BC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:00:16 -0400
Received: by mail-io0-x22e.google.com with SMTP id k91so53390176ioi.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:00:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c674491-b570-bed1-6d39-293ce8c5e5fc@redhat.com>
References: <20170530085346.1730-1-roman.penyaev@profitbricks.com>
	<3c674491-b570-bed1-6d39-293ce8c5e5fc@redhat.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Tue, 30 May 2017 11:59:55 +0200
Message-ID: <CAJrWOzA-eE8QZ-i_sDQE2Bq_2hxx4gPZst-75gY7S+hjo2WmVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] coroutine-lock: do not touch coroutine
 after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, May 30, 2017 at 11:35 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 30/05/2017 10:53, Roman Pen wrote:
>> The fix is obvious: use temporal queue and do not touch coroutine after
>> first qemu_coroutine_enter() is invoked.
>>
>> The issue is quite rare and happens every ~12 hours on very high IO load
>> (building linux kernel with -j512 inside guest) when IO throttling is
>> enabled.  With the fix applied guest is running ~35 hours and is still
>> alive so far.
>
> This is a good one.  Thanks!  Just a couple notes on English below.

I like your variant, thanks, explaining knotty things is my weak point.
Will resend v2 shortly.

--
Roman
