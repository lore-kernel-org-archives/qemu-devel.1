Received: from eggs.gnu.org ([2001:4830:134:3::10]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cX2Pk-00018I-EG
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cX2Ph-0003NZ-Cf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:01:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cX2Ph-0003Mu-50
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:01:45 -0500
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
	<20170125110529.5rgu7xrh3gkoadog@dhcp-3-221.uk.xensource.com>
	<20170126154509.rxi5sy4bcob2ioen@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701261017370.2884@sstabellini-ThinkPad-X260>
	<CAFEAcA__2S3jTKEFy3Ue=Vvw+tuE1Du573PQp-VYOa6jBRpWCw@mail.gmail.com>
	<CAFEAcA_1cEbnBg9KA35y0OTk_Hw+bng2Guof84WuKfRWhx1A6g@mail.gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <4ab0b43d-8384-ef30-49b1-1edd7b498ca1@suse.com>
Date: Fri, 27 Jan 2017 10:01:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1cEbnBg9KA35y0OTk_Hw+bng2Guof84WuKfRWhx1A6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 26/01/17 22:21, Peter Maydell wrote:
> On 26 January 2017 at 20:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 26 January 2017 at 19:36, Stefano Stabellini <sstabellini@kernel.org> wrote:
>>> It should be just a matter of replacing qdev_init_nofail with something
>>> that can fail. I couldn't find a regular qdev_init that can return
>>> error, so maybe we would need to add it.
>>
>> That's just
>>     object_property_set_bool(OBJECT(whatever), true, "realized", &err);
>>
>> ie "please realize the device".
> 
> (PS watch out for ownership refcounting issues depending on what
> you did with parenting the device: you likely want to object_unparent()
> and then object_unref() the thing in the error-exit path. See
> qdev_device_add() for some example code, maybe.)

I'll have a try later today or early next week.


Juergen
