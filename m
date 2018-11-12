Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMLfH-0004NC-H3
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMLfE-0002bk-6k
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:30:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMLfE-0002bc-0N
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 18:30:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so10180877wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 15:30:39 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-3-f4bug@amsat.org>
	<20181112223027.GZ12503@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1dd5cf1d-56e7-ab13-fc72-3bd5cbccb26d@redhat.com>
Date: Tue, 13 Nov 2018 00:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181112223027.GZ12503@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] decodetree: Add multiple include
 guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cleber Rosa <crosa@redhat.com>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12/11/18 23:30, Eduardo Habkost wrote:
> On Mon, Nov 12, 2018 at 12:36:13AM +0100, Philippe Mathieu-Daudé wrote:
>> It is necessary when splitting an ISA, or when using multiple ISAs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> TODO: explain why, use case
>> TODO: escape full path?
>> ---
>>   scripts/decodetree.py | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
>> index 0bc73b5990..5dea15e7a5 100755
>> --- a/scripts/decodetree.py
>> +++ b/scripts/decodetree.py
>> @@ -1030,7 +1030,11 @@ def main():
>>       else:
>>           output_fd = sys.stdout
>>   
>> +    hdr_guard = filename.split(os.path.sep)[-1].upper().replace('.', '_') + "_H"
> 
> Isn't
>    filename.split(os.path.sep)[-1]
> equivalent to
>    os.path.basename(filename)
> ?

Yes, thanks :)
