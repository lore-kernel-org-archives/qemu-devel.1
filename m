Received: from eggs.gnu.org ([2001:4830:134:3::10]:60077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crSxh-0001EU-S5
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crSxd-0003zR-Tk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:17 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1crSxd-0003zD-Lk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:25:13 -0400
Received: by mail-wr0-x230.google.com with SMTP id y90so6123582wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 10:25:13 -0700 (PDT)
References: <20170324152607.6604-1-alex.bennee@linaro.org>
	<fa4d3712-859a-ced3-3883-8951ee9b6aa7@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fa4d3712-859a-ced3-3883-8951ee9b6aa7@redhat.com>
Date: Fri, 24 Mar 2017 17:25:10 +0000
Message-ID: <871stmy4cp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH-for-2.9] replay/replay.c: bump
 REPLAY_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org


Eric Blake <eblake@redhat.com> writes:

> On 03/24/2017 10:26 AM, Alex Bennée wrote:
>> A previous commit (3d4d16f4) added support for audio record/playback.
>> However this breaks the logfile ABI due to the re-ordering of the
>> ReplayEvents enum. The REPLAY_VERSION check is meant to prevent you
>> from using old log files in newer QEMUs but this is currently broken.
>
> As we don't have a formal release with the reordered enum yet, would an
> alternative approach be partially reverting 3d4d16f4 to instead stick
> the new enum values at the end, so that all existing enums are in the
> same order?

That would certainly be an option.

> Or do you still need the version bump even then, because
> you don't want a new stream (with the new enums) being played to an
> older system that isn't expecting them?

I'm not personally bothered either way. Currently the check is a simple
match so there is not really the concept of a super/subsets of log file.

I only ran into this as I was trying to debug the record/replay
regression while writing a dumper script to debug the current
regression:

  https://github.com/stsquad/qemu/blob/mttcg/more-fixes-for-rc1-v2/scripts/replay-dump.py

--
Alex Bennée
