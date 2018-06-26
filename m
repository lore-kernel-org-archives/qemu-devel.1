Received: from eggs.gnu.org ([2001:4830:134:3::10]:51281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXipG-0001Sb-Rr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXipD-0003IH-Q7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:55:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXipD-0003I4-KG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 03:55:43 -0400
References: <20180514141218.28438-1-pbonzini@redhat.com>
	<87a7riovly.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7826b2c7-4cbf-6090-415d-d7866b6c9a89@redhat.com>
Date: Tue, 26 Jun 2018 09:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <87a7riovly.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On 26/06/2018 09:27, Markus Armbruster wrote:
> 
> Minimal fix:
> 
>     diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
>     index 48b112393b..f987ce53b8 100644
>     --- a/scripts/coverity-model.c
>     +++ b/scripts/coverity-model.c
>     @@ -106,6 +106,7 @@ static int get_keysym(const name2keysym_t *table,
>      /* Replay data is considered trusted.  */
>      uint8_t replay_get_byte(void)
>      {
>     +    void *replay_file;
>           uint8_t byte = 0;
>           if (replay_file) {
>               uint8_t c;
> 
> Alternatively, dumb down to:
> 
>     /* Replay data is considered trusted.  */
>     uint8_t replay_get_byte(void)
>     {
>         uint8_t byte;
>         return byte;
>     }

I wonder why the online service didn't complain.  I guess the dumber
version is more than enough!

Paolo
