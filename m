Received: from eggs.gnu.org ([2001:4830:134:3::10]:45636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSnIm-00057K-71
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSnIl-0006Jv-Ao
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:41:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba3865c5-dd60-8da2-9f99-33723ae26c2b@amsat.org>
Date: Tue, 12 Jun 2018 14:41:40 -0300
MIME-Version: 1.0
In-Reply-To: <650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/12/2018 02:30 PM, Richard Henderson wrote:
> On 06/11/2018 04:17 AM, Peter Maydell wrote:
>> The codebase has a bit of a mix of different multiline
>> comment styles. State a preference for the Linux kernel
>> style:
>>     /*
>>      * Star on the left for each line.
>>      * Leading slash-star and trailing star-slash
>>      * each go on a line of their own.
>>      */
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This is not my personal favourite, but seemed to be the
>> closest we had to consensus in the mail thread for v1;
>> I can live with it in order to avoid getting patches which
>> use the styles I like even less :-)
> 
> Honestly, I don't like this except for "important" comments.
> 
> A "small" comment, e.g. one that doesn't quite fit on a single line, now takes
> 4 lines instead of 2.  Which is really annoying and IMO tends to break flow.
> 
> If you don't like
> 
>   /* gnu
>      style */
> 
> or
> 
>   /* whatever
>    * this is */
> 
> could you live with
> 
>   // c99/c++
>   // comments
> 
> (I know we currently deny those in checkpatch, but that's easy enough to remove
> if we're changing policy.  I have no idea why we don't like them in the first
> place.  Or other c99 features like mid-block or control declarations, for that
> matter.)

+1 for control declarations :) Code is easier to read and keep focus on.

3.0 release is a good opportunity to establish such disruptive changes.
