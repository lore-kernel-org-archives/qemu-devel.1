Received: from eggs.gnu.org ([2001:4830:134:3::10]:54012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsxc-0005SV-Gh
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsxZ-0005nn-CR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:04:48 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZsxZ-0005nf-6x
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:04:45 -0400
Received: by mail-qt0-x230.google.com with SMTP id v29so2635405qtv.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 23:04:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-7-ldoktor@redhat.com>
	<989e2216-499c-3c22-3958-0c51ac342dd1@amsat.org>
	<b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2cb14375-2300-83d5-a689-db5aadf2cf20@amsat.org>
Date: Tue, 25 Jul 2017 03:04:40 -0300
MIME-Version: 1.0
In-Reply-To: <b772f95e-9a3a-0a72-e6c6-7390902f62d1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] qmp.py: Couple of pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

Hi Lukáš,

On 07/24/2017 09:36 AM, Lukáš Doktor wrote:
> Dne 22.7.2017 v 03:30 Philippe Mathieu-Daudé napsal(a):
>> Hi Lukáš,
>>
>> Since comment/indent fixes and code changes are not related I'd rather see this split in at least 2 patches.
>>
> Hello Philippe, thank you for the review, I'm wondering what code changes you have in mind? This is commit should not bring any code changes, just code reorganization (like including the self.* attributes on top of the file)
> 
>> On 07/20/2017 01:28 PM, Lukáš Doktor wrote:
>>> No actual code changes, just a few pylint/style fixes and docstring
>>> clarifications.
>>>
>>> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>
>>> ---
>>>    scripts/qmp/qmp.py | 37 ++++++++++++++++++++++++-------------
>>>    1 file changed, 24 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
[...]
>>>        def __init__(self, address, server=False, debug=False):
>>>            """
>>>            Create a QEMUMonitorProtocol class.
>>> @@ -42,6 +53,7 @@ class QEMUMonitorProtocol:
>>>            self.__address = address
>>>            self._debug = debug
>>>            self.__sock = self.__get_sock()
>>> +        self.__sockfile = None

I was thinking about this line which is new. Now the declaration and 
initialization are done in __init__() while before it was only 
declared/initialized in connect() or accept().

I'm not expert of python interpreter/jit internals but expect the 
generated code to be slightly different, even if achieving the same.

not a bit deal, just about wording ;)

>>>            if server:
>>>                self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
>>>                self.__sock.bind(self.__address)
