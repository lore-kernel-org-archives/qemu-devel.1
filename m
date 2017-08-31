Received: from eggs.gnu.org ([2001:4830:134:3::10]:33427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRHB-00066g-S2
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRH7-0006zK-UE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:21:01 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRH7-0006zE-PU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:20:57 -0400
Received: by mail-qk0-x233.google.com with SMTP id l65so4233573qkc.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:20:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <800abf63-db3f-78c7-0580-8d86479fdf5a@amsat.org>
Date: Thu, 31 Aug 2017 12:20:53 -0300
MIME-Version: 1.0
In-Reply-To: <be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/31/2017 02:19 AM, Thomas Huth wrote:
> On 31.08.2017 05:53, Philippe Mathieu-Daudé wrote:
[...]>> +Chardev *serial_chr_nonnull(Chardev *chr)
>> +{
>> +    static int serial_id;
>> +    char *label;
>> +
>> +    label = g_strdup_printf("discarding-serial%d", serial_id++);
>> +    chr = qemu_chr_new(label, "null");
> 
> That looks wrong - you're ignoring the input parameter and always open
> the "null" device? Shouldn't there be a "if (chr) return chr;" in front
> of this?

You right. I had this correct in my first patch when this code was 
embedded, I then failed at extracting as another function :/

> 
>> +    assert(chr);
>> +    g_free(label);
>> +
>> +    return chr;
>> +}
> 
>   Thomas
> 
> PS: I think you should also merge the two patches together, they are
> small enough.

Ok.
