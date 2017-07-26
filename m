Received: from eggs.gnu.org ([2001:4830:134:3::10]:44018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daV6p-0003rC-QQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daV6p-0006pl-4X
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:48:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-4-f4bug@amsat.org>
	<acb16999-952f-bd1e-254b-befe65a259d3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <06c19484-b285-ccd8-90d1-2557191b6d2e@amsat.org>
Date: Wed, 26 Jul 2017 19:48:38 -0300
MIME-Version: 1.0
In-Reply-To: <acb16999-952f-bd1e-254b-befe65a259d3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 03/35] thunk: check nb_fields is
 valid before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 07/24/2017 03:37 PM, Eric Blake wrote:
> On 07/24/2017 01:27 PM, Philippe Mathieu-Daudé wrote:
>> thunk.c:91:32: warning: Call to 'malloc' has an allocation size of 0 bytes
>>          se->field_offsets[i] = malloc(nb_fields * sizeof(int));
>>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   thunk.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Better would be fixing the code to use g_new0, and the corresponding free.

Ok, for 2.11 although (not a fix).

Also thunk* alloc'd are never free'd during process lifetime, so will 
keep like that (no g_free).
