Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKaG-0000SJ-Q2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKaB-0006SY-9A
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:48 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:33415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNKaB-0006SP-1i
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:43 -0400
Received: by mail-lf0-x234.google.com with SMTP id m77so75898106lfe.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:56:42 -0700 (PDT)
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-14-alex.bennee@linaro.org>
	<CAFEAcA9TWKc9Py=MMMsMpGU7+n-8FJf-Xrd_7951xMMQ4YBY+w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9TWKc9Py=MMMsMpGU7+n-8FJf-Xrd_7951xMMQ4YBY+w@mail.gmail.com>
Date: Tue, 20 Jun 2017 15:57:23 +0100
Message-ID: <87wp86u2p8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v5 13/13] new: run_risu.sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2017 at 11:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>> A simple script to work through running all of a bunch of files with
>> record/playback traces. Dumps a summary and the number of failed tests
>> at the end.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v5
>>   - author, license, usage header
>> v3
>>   - tweak to allow specifying RISU binary
>> ---
>>  run_risu.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100755 run_risu.sh
>>
>> diff --git a/run_risu.sh b/run_risu.sh
>
> I think this should go into contrib/.

OK will do.

>
> thanks
> -- PMM


--
Alex Bennée
