Received: from eggs.gnu.org ([209.51.188.92]:46115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3L6X-0007Z7-Co
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3L6W-0003vX-HR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:36:33 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3L6W-0003uo-4j
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:36:32 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311103029.GF16@765644dd90e5>
	<1ab60a5e-bb20-5b13-6ddf-ebb8e28b3a08@vivier.eu>
	<CAGZZdDFXPkS__qyHCYbEdNz+0jY_MorSux3HAJnpi7pxTUN07g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ef1bf7aa-cbca-37a0-5885-b3838c9c81cd@vivier.eu>
Date: Mon, 11 Mar 2019 14:36:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAGZZdDFXPkS__qyHCYbEdNz+0jY_MorSux3HAJnpi7pxTUN07g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/10] qemu-binfmt-conf.sh: generalize
 CPU to positional TARGETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

On 11/03/2019 14:29, Unai Martinez Corral wrote:
> 2019/3/11 12:14, Laurent Vivier:
>> On 11/03/2019 11:30, Unai Martinez-Corral wrote:
> 
>>> +        if [ "$unknown_target" = "true" ] ; then
>>
>>            if [ "x$cpu" != "x$target" ] ; then
> 
> My bad. I fixed it before squashing, and broke it again when doing it.
> 
>>> +-s|--systemd:                         don't write into /proc, generate file(s) for
>>> +                                      systemd-binfmt.service; environment variable HOST_ARCH
>>
>> why HOST_ARCH appears here?
> 
> The existing comment seems to be specific to systemd:
> https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh#L201-L204
> 'systemd' is the single mode in which it makes sense to generate a
> bunch of configuration files for a different architecture than the
> current one, isn't it?

No, it's not specific to systemd. If we register an interpreter for the
current architecture we can make it unusable.

I've proposed sometime ago a kernel patch to set binfmt_misc
configuration by namespace to avoid this kind of problem but it has
never been merged:

  [v6,0/1] ns: introduce binfmt_misc namespace
  https://patchwork.kernel.org/cover/10634807/

Thanks,
Laurent
