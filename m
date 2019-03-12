Received: from eggs.gnu.org ([209.51.188.92]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h3aVz-0000h0-GF
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h3aVy-0003kR-0D
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:03:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1h3aVx-0003i3-9a
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 02:03:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id m2so1004684pgl.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 23:03:47 -0700 (PDT)
References: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
	<e942cdab-fe1b-fdf4-3b9f-da16a4afa953@kaod.org>
	<CAJ+F1C+hFfsa5gcSdttTP5J+uyDvNdYJWrm9OJM26+Zc1ZQkew@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cc62e1fd-c564-e1b7-d10c-30665b481352@ozlabs.ru>
Date: Tue, 12 Mar 2019 17:03:36 +1100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+hFfsa5gcSdttTP5J+uyDvNdYJWrm9OJM26+Zc1ZQkew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Clearing slirp/ license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, gwshan@linux.vnet.ibm.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, shan.gavin@gmail.com

Gavig left the company sometime ago, cc:ing his gmail.


On 12/03/2019 05:01, Marc-André Lureau wrote:
> Hi Cédric, Gavin,
> 
> On Mon, Mar 11, 2019 at 4:23 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 2/13/19 12:03 PM, Marc-André Lureau wrote:
>>> Hi,
>>>
>>> As we are trying to move slirp/ in a standalone project, which
>>> eventually could be installed as a shared library, we need to clear
>>> the license.
>>>
>>> slirp is supposed to be 3-Clause BSD license (according to
>>> https://git.qemu.org/?p=qemu.git;a=commit;h=2f5f89963186d42a7ded253bc6cf5b32abb45cec)
>>> but it seems to be effectively a 2-Clause BSD (the third clause is not
>>> in COPYRIGHT)
>>>
>>> However, there are two units that are GPL-2:
>>>
>>> - dhcpv6.c, dhcpv6.h:
>>>   The code was contributed by Thomas Huth <thuth@redhat.com>
>>>
>>> $ git shortlog -nes slirp/dhcpv6.{c,h}
>>>      6  Marc-André Lureau <marcandre.lureau@redhat.com>
>>>      1  Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>      1  Thomas Huth <thuth@redhat.com>
>>>      1  Yuval Shaia <yuval.shaia@oracle.com>
>>>
>>> - ncsi.c, ncsi-pkt.h:
>>>   The code was contributed by Cédric Le Goater <clg@kaod.org>
>>>
>>> $ git shortlog -nes slirp/ncsi.c slirp/ncsi-pkt.h
>>>      5  Marc-André Lureau <marcandre.lureau@redhat.com>
>>>      4  Cédric Le Goater <clg@kaod.org>
>>>
>>> Could you reply that you have no objection in relicensing those files
>>> are 3-Clause BSD?
>>
>> Fine for me. You can change the license of slirp/ncsi.c and
>> slirp/ncsi-pkt.hto a 3-Clause BSD.
> 
> I noticed that ncsi-pkt.h has "Copyright Gavin Shan, IBM Corporation 2016"
> 
> I suppose Gavin should also give his agreement to relicense the file.
> 
> 
> Gavin, could you reply that you have no objection in relicensing
> ncsi-pkt.h as 3-Clause BSD?
> 
> 
> Thanks
> 
>>
>> Thanks,
>>
>> C.
>>
>>> After "[Qemu-devel] [PATCH 0/7] slirp: make it a standalone project",
>>> the vmstate subset that I adapted would also need to be relicensed.
>>> There are more contributors here, I am not sure how it should be
>>> handled. Any idea?
>>>
>>> thanks
>>>
>>
> 
> 

-- 
Alexey
