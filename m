Received: from eggs.gnu.org ([2001:4830:134:3::10]:38011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhM0r-00063Q-B4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhM0o-00073Y-54
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:31:01 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhM0o-00072u-0E
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:30:58 -0400
Received: by mail-qk0-x234.google.com with SMTP id u139so56546093qka.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 13:30:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30786c66-bcee-93fe-a682-492298608f1d@amsat.org>
Date: Mon, 14 Aug 2017 17:30:49 -0300
MIME-Version: 1.0
In-Reply-To: <223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi John,

On 08/14/2017 10:39 AM, Programmingkid wrote:
> 
>> On Aug 14, 2017, at 8:50 AM, qemu-devel-request@nongnu.org wrote:
>>
>> An update of:
>>
>>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>>
>> The keycodemap project[1] provides a database mapping between
>> many different keysym/keycode/scancode sets, along with a
>> tool to generate mapping/lookup tables in various programming
>> languages. It is already used by GTK-VNC, SPICE-GTK and
>> libvirt.
>>
>> This series enables its use in QEMU, thus fixing a great
>> many bugs/ommissions in the 15+ key mapping tables people
>> have manually written for QEMU.
> 
> Would you have a git repository that has all your patches already applied? It would make testing your patches a lot easier.
> 
> Thank you.

You can create an account on patchwork then look for Daniel's series:
http://patchwork.ozlabs.org/project/qemu-devel/list/?submitter=2694

Select it then click on "Create bundle", once created you can download 
it in a mailbox format to import with 'git am':
http://patchwork.ozlabs.org/project/qemu-devel/bundles/


Also many UI email client supporting threads view has feature to select 
the thread and right click "Save as ..." "EML" or "Mbox format" which 
are fine with 'git am' too.

Thunderbird have some plugins to ease git workflow:

https://addons.mozilla.org/en-US/thunderbird/addon/colored-diffs/
https://addons.mozilla.org/en-US/thunderbird/addon/importexporttools/

Regards,

Phil.
