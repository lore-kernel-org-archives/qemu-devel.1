Received: from eggs.gnu.org ([209.51.188.92]:60323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gtDjH-0002jY-8w
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gtDj9-0006oo-43
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:42:39 -0500
Received: from smtp57.i.mail.ru ([217.69.128.37]:54118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gtDj6-0006jq-5X
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:42:33 -0500
References: <20190131202637.4062-1-jusual@mail.ru>
	<87lg2zj2f2.fsf@dusky.pond.sub.org>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <d10b10d5-0600-515b-66d7-e6f448f42ced@mail.ru>
Date: Mon, 11 Feb 2019 18:42:24 +0300
MIME-Version: 1.0
In-Reply-To: <87lg2zj2f2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 01.02.2019 12:14, Markus Armbruster wrote:
> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org> writes:
> 
>> The whitelist option allows to run a reduced monitor with a subset of
>> QMP commands. This allows the monitor to run in secure mode, which is
> 
> For a value of "secure".  I'm not saying this can't be useful, just
> tempering expecations.  I guess you intend to use this to restrict the
> monitor to sufficiently harmless commands, such as commands that merely
> return information without changing anything.  However, even such
> commands can be abused for denial of service.  Whether that's an issue
> depends on your use case.
> 
>> convenient for sending commands via the WebSocket monitor using the
>> web UI. This is planned to be done on micro:bit board.
>>
>> The list of allowed commands should be written to a file, one per line.
>> The command line will look like this:
>>      -mon chardev_name,mode=control,whitelist=path_to_file
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> 
> Please describe your intended use case in more detail, and provide at
> least a rough security analysis that includes the denial of service
> aspect.

It is planned to use the web interface for micro:bit board, e.g. send a
button press as a QMP command and send a LED display changing as a QMP
event, and send them via WebSocket protocol from QEMU to a web page.
The monitor will also send commands from some other sensors, for
example, an accelerometer/magnetometer. Therefore, it is convenient to
limit the monitor so that it can send only these commands of
buttons/sensors.

Best regards, Julia Suvorova.
