Received: from eggs.gnu.org ([2001:4830:134:3::10]:60538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjlE-0003Go-Oq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXjlC-0006oj-6K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:55:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fXjlC-0006oQ-0w
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:55:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180514141218.28438-1-pbonzini@redhat.com>
	<87a7riovly.fsf@dusky.pond.sub.org>
	<7826b2c7-4cbf-6090-415d-d7866b6c9a89@redhat.com>
Date: Tue, 26 Jun 2018 10:55:36 +0200
In-Reply-To: <7826b2c7-4cbf-6090-415d-d7866b6c9a89@redhat.com> (Paolo
	Bonzini's message of "Tue, 26 Jun 2018 09:55:39 +0200")
Message-ID: <8736xakjuf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] coverity-model: replay data is considered
 trusted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/06/2018 09:27, Markus Armbruster wrote:
>> 
>> Minimal fix:
>> 
>>     diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
>>     index 48b112393b..f987ce53b8 100644
>>     --- a/scripts/coverity-model.c
>>     +++ b/scripts/coverity-model.c
>>     @@ -106,6 +106,7 @@ static int get_keysym(const name2keysym_t *table,
>>      /* Replay data is considered trusted.  */
>>      uint8_t replay_get_byte(void)
>>      {
>>     +    void *replay_file;
>>           uint8_t byte = 0;
>>           if (replay_file) {
>>               uint8_t c;
>> 
>> Alternatively, dumb down to:
>> 
>>     /* Replay data is considered trusted.  */
>>     uint8_t replay_get_byte(void)
>>     {
>>         uint8_t byte;
>>         return byte;
>>     }
>
> I wonder why the online service didn't complain.

Me too.  Of course, I should've run cov-make-library myself.  Next
time...

>                                                   I guess the dumber
> version is more than enough!

I'll post it as a proper patch.  Thanks!
