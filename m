Received: from eggs.gnu.org ([2001:4830:134:3::10]:46528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA6r4-0003vC-6i
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 00:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA6r1-0001DO-15
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 00:11:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-89-f4bug@amsat.org>
	<87po9wstr2.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1a1dcb1-ca42-e03a-cefc-fd8fa4dd5fff@amsat.org>
Date: Thu, 2 Nov 2017 01:11:36 -0300
MIME-Version: 1.0
In-Reply-To: <87po9wstr2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 88/88] scripts/coverity-model: use g_new()
 family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org

Hi Markus,

On 10/09/2017 03:46 AM, Markus Armbruster wrote:
> Please cc me on changes to stuff I maintain, as scripts/get_maintainer
> tells you :)

Oops I might have been a copy/paste error.

> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  scripts/coverity-model.c | 2 +-
[...]
>>  GIOChannel *g_io_channel_unix_new(int fd)
>>  {
>> -    GIOChannel *c = g_malloc0(sizeof(GIOChannel));
>> +    GIOChannel *c = g_new0(GIOChannel, 1);
>>      __coverity_escape__(fd);
>>      return c;
>>  }
> 
> Hmm.
> 
> The Coverity model carefully explains g_malloc0().  It doesn't explain
> g_new0().  With any luck, Coverity can see through g_new0() --- it's a
> macro in my <gmem.h>.  But why complicate matters?  The normal reason
> for changing g_malloc0() to g_new0() doesn't apply here.  Let's leave
> the model alone.

Yes you are right.
