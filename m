Received: from eggs.gnu.org ([2001:4830:134:3::10]:59284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6xF-0003nU-Ef
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6xA-000315-Eb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:18:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180705155811.20366-1-f4bug@amsat.org>
	<20180705155811.20366-5-f4bug@amsat.org>
	<af8abd7f-d72d-0445-298c-4ff91fccdb5e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f83286cc-e70e-596d-58ce-4b3f4e715d8e@amsat.org>
Date: Thu, 5 Jul 2018 13:17:51 -0300
MIME-Version: 1.0
In-Reply-To: <af8abd7f-d72d-0445-298c-4ff91fccdb5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] tests/bios-tables-test: Remove an
 useless cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 07/05/2018 01:13 PM, Eric Blake wrote:
> On 07/05/2018 10:58 AM, Philippe Mathieu-Daudé wrote:
>> Patch created mechanically by rerunning:
> 
> In the subject: s/an useless/a useless/
> 
> (English is weird; we use "a" when the 'u' is pronounced hard as in
> "unicorn", and "an" when the 'u' is soft as in "umbrella")

TIL, thanks for catching/correcting this Eric :)

>>
>>    $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>>              --macro-file scripts/cocci-macro-file.h \
>>              --dir . --in-place
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
