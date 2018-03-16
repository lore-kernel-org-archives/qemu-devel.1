Received: from eggs.gnu.org ([2001:4830:134:3::10]:48543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ewmzw-0003EH-BC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ewmzq-0000VE-JF
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:54:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36513
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ewmzq-0000Ru-C7
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:54:02 -0400
References: <20180314080439.4229-1-kraxel@redhat.com>
	<6d70d198-62d7-fd48-cef5-7b470c249de4@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4f2b42d8-30a1-a54f-efc4-c359ab124c40@ilande.co.uk>
Date: Fri, 16 Mar 2018 10:53:44 +0000
MIME-Version: 1.0
In-Reply-To: <6d70d198-62d7-fd48-cef5-7b470c249de4@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gtk: drop pointless code from
 gd_window_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 15/03/18 11:35, Philippe Mathieu-Daudé wrote:

> On 03/14/2018 09:04 AM, Gerd Hoffmann wrote:
>> Unregistering the display change listener looks like a pointless
>> excercise given we'll exit in a moment.  When exiting qemu via
> 
> exercise
> 
>> menu/file/quit this will not happen either.  Just drop the code.
>>
>> Also return TRUE unconditionally.  This will tell gtk to ignore the
>> close request, so gtk will not start destroying widgets and causing
>> warnings due to UI code trying to talk to widgets which are gone.
>> Just depend on qmp_quit() doing it's job instead.
>>
>> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Looks fine to me.
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Mark, is your issue resolved? (you might add your Tested-by).

Yes, I can confirm that this patch fixes my test case.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
