Received: from eggs.gnu.org ([2001:4830:134:3::10]:56293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQ3ey-00025I-2z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQ3eu-0006II-Vw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:33:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQ3eu-0006Hx-Qn
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 00:33:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FF0F40122B5
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 04:33:24 +0000 (UTC)
Received: from [10.36.116.62] (ovpn-116-62.ams2.redhat.com [10.36.116.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D09C7111AF36
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 04:33:23 +0000 (UTC)
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52a5446f-4624-fd45-ce7d-492269aa5c3f@redhat.com>
Date: Tue, 5 Jun 2018 06:33:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180604191756.1ae61871@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 05.06.2018 03:17, Alex Williamson wrote:
> On Mon,  4 Jun 2018 17:21:40 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> The codebase has a bit of a mix of
>>  /* multiline comments
>>   * like this
>>   */
>> and
>>  /* multiline comments like this
>>     in the GNU Coding Standards style */
>>
>> State a preference for the former.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I admit that to some extent I'm imposing my aesthetic
>> preferences here; pretty sure we have a lot more style
>> 1 comments than style 2, though.
>> ---
>>  CODING_STYLE | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/CODING_STYLE b/CODING_STYLE
>> index 12ba58ee293..fb1d1f1cd62 100644
>> --- a/CODING_STYLE
>> +++ b/CODING_STYLE
>> @@ -124,6 +124,19 @@ We use traditional C-style /* */ comments and avoid // comments.
>>  Rationale: The // form is valid in C99, so this is purely a matter of
>>  consistency of style. The checkpatch script will warn you about this.
>>  
>> +Multiline comments blocks should have a row of stars on the left
>> +and the terminating */ on its own line:
>> +    /* like
>> +     * this
>> +     */
>> +Putting the initial /* on its own line is accepted, but not required.
> 
> Could we say "at maintainer discretion", or is that always implied?  The
> asymmetry of the proposed standard is not my favorite and a mostly
> blank line before and after further supports standing out from
> surrounding code. 
I also don't like the asymmetry. I'd prefer more dense comments, though:

  /* like
   * this */

Anyway, could we either use that dense format or the kernel-style
multi-lines-comment format, please? Mixing it asymmetrically is just ugly.

 Thomas
