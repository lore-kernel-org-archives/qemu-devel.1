Received: from eggs.gnu.org ([2001:4830:134:3::10]:38775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLt8D-0005X5-BD
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLt8C-00008L-Gh
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:58:09 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLt8C-00007z-CQ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:58:08 -0500
Received: by mail-oi0-x232.google.com with SMTP id w125so11981848oie.7
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 07:58:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa45711a-9203-423f-b9a9-e2006847f6f4@redhat.com>
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
	<fa45711a-9203-423f-b9a9-e2006847f6f4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 15:57:46 +0000
Message-ID: <CAFEAcA-kO_cJKUs5sPkL5ynLd+nNrKac4dgUT-=1QmBC=e7qkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Shravan Rajinikanth <shravan2x@utexas.edu>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 4 December 2017 at 15:51, Max Reitz <mreitz@redhat.com> wrote:
> On 2017-12-02 23:37, Shravan Rajinikanth wrote:
>> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
>> ---
>>  qemu-img.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 68b375f..bea9268 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
>>          if (check->leaks) {
>>              qprintf(quiet,
>>                      "\n%" PRId64 " leaked clusters were found on the image.\n"
>> -                    "This means waste of disk space, but no harm to data.\n",
>> +                    "This means disk space is wasted, but data is safe.\n",
>>                      check->leaks);
>>          }
>
> How exactly is this a grammatical error?  (I'm not a native English
> speaker, but it always seemed perfectly OK to me)

I think "This means" more naturally takes a verb phrase, not a noun phrase.
I don't know that I'd go so far as to say that the current text is
ungrammatical, but I do think the proposed change sounds more natural to me.

thanks
-- PMM
