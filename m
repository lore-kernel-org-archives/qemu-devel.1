Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fDoVO-0000ho-LM
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fDoVL-0005FK-I0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:56:58 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:42327
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1fDoVL-0005E3-9P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:56:55 -0400
References: <20180419131051.11249-1-kraxel@redhat.com>
	<20180419131051.11249-5-kraxel@redhat.com>
	<833e23a9-4899-2a95-c4b1-027d437e2ef7@adacore.com>
	<20180425130525.omdcdwvcpclk7xsu@sirius.home.kraxel.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <9baf8882-0458-0865-d712-aa2d723c3c78@adacore.com>
Date: Wed, 2 May 2018 11:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180425130525.omdcdwvcpclk7xsu@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] audio/hda: detect output buffer
 overruns and underruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, martin@schrodt.org

Hi Gerd,

Sorry I didn't had time to try that yet.

I'll try today!

Thanks,
Fred

On 04/25/2018 03:05 PM, Gerd Hoffmann wrote:
> On Mon, Apr 23, 2018 at 11:31:34AM +0200, KONRAD Frederic wrote:
>>
>>
>> On 04/19/2018 03:10 PM, Gerd Hoffmann wrote:
>>> If some event caused some larger playback hickup the fine-grained timer
>>> adjust isn't able to recover.  Use a buffer overruns and underruns as
>>> indicator for that.  Reset timer adjust logic in case we detected one.
>>
>> It seems that this patch causes big lockup of my Win10 KVM guest
>> when it tries to output a sound.
>> The three previous patches improved considerably the audio
>> output though!
> 
> Can you try drop the "underrun" chunks, keeping only the "overrun"?
> 
> thanks,
>    Gerd
> 
