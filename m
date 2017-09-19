Received: from eggs.gnu.org ([2001:4830:134:3::10]:59327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duF9Q-0006bt-Ot
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duF9P-0003rY-RQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:49:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918221124.17159-1-f4bug@amsat.org>
	<20170919020837.GA11534@lemon.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8cc735e-3f23-5a0c-4e31-d253111fcee0@amsat.org>
Date: Tue, 19 Sep 2017 06:48:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170919020837.GA11534@lemon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] msf2: drop cpu_model to directly use cpu
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>

On 09/18/2017 11:08 PM, Fam Zheng wrote:
> On Mon, 09/18 19:11, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> after Igor comment:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04709.html
>>
>> Fam: I'm trying your patchew "apply over series" feature on these 2 series,
>>       hoping they get both applied before my patch:
>>
>> Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
>> Based-on: 1505762601-27143-6-git-send-email-sundeep.lkml@gmail.com
> 
> Only one based-on will be picked up, so this doesn't work. Patchew basically
> applies the series on top of something, where something is the result of a
> previous applying. So it can be thought of a chain.

OK, here I used each series trail, luckily they apply independently.
It seems your script only kept/used then last Based-on.

> 
> To support multiple patches, a different approach needs to be implemented.
> 
> Fam
> 
