Received: from eggs.gnu.org ([2001:4830:134:3::10]:59900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crRVA-0002r1-UE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crRV7-0002rl-PW
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:51:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1crRV7-0002pC-Fj
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:51:41 -0400
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
	<da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
	<alpine.DEB.2.10.1703211152240.11679@sstabellini-ThinkPad-X260>
	<f1f79b77-f3bf-4bb0-135c-802bd5829de5@suse.com>
	<alpine.DEB.2.10.1703221120530.13499@sstabellini-ThinkPad-X260>
	<2fb1da9d14c14eb4826a87657f7d0eb1@AMSPEX02CL03.citrite.net>
	<550ea61e-c9ba-5afc-12b5-438a2a57af6e@suse.com>
	<7208ddd9b76b4196be0a3d3cd12aee71@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <20f2b3ce-218b-4d61-6af1-8c70b751ed18@suse.com>
Date: Fri, 24 Mar 2017 16:51:38 +0100
MIME-Version: 1.0
In-Reply-To: <7208ddd9b76b4196be0a3d3cd12aee71@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/2] configure: use pkg-config
 for obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>

On 24/03/17 16:44, Paul Durrant wrote:
>> -----Original Message-----
>> From: Juergen Gross [mailto:jgross@suse.com]
>> Sent: 24 March 2017 15:35
>> To: Paul Durrant <Paul.Durrant@citrix.com>; 'Stefano Stabellini'
>> <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>; xen-
>> devel@lists.xenproject.org; qemu-devel@nongnu.org; kraxel@redhat.com
>> Subject: Re: [Xen-devel] [PATCH 2/2] configure: use pkg-config for obtaining
>> xen version
>>
>> On 24/03/17 16:12, Paul Durrant wrote:
>>>> -----Original Message-----
>>>> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
>>>> Sent: 22 March 2017 18:22
>>>> To: Juergen Gross <jgross@suse.com>
>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>; qemu-
>> devel@nongnu.org;
>>>> xen-devel@lists.xenproject.org; Anthony Perard
>>>> <anthony.perard@citrix.com>; kraxel@redhat.com; Paul Durrant
>>>> <Paul.Durrant@citrix.com>
>>>> Subject: Re: [PATCH 2/2] configure: use pkg-config for obtaining xen
>> version
>>>>
>>>> On Wed, 22 Mar 2017, Juergen Gross wrote:
>>>>> On 21/03/17 19:54, Stefano Stabellini wrote:
>>>>>> On Tue, 21 Mar 2017, Juergen Gross wrote:
>>>>>>> On 17/03/17 19:33, Stefano Stabellini wrote:
>>>>>>>> On Fri, 17 Mar 2017, Juergen Gross wrote:
>>>>>>>>> On 16/03/17 21:20, Stefano Stabellini wrote:
>>>>>>>>>> On Thu, 16 Mar 2017, Juergen Gross wrote:
>>>>>>>>>>> Instead of trying to guess the Xen version to use by compiling
>>>> various
>>>>>>>>>>> test programs first just ask the system via pkg-config. Only if it
>>>>>>>>>>> can't return the version fall back to the test program scheme.
>>>>>>>>>>
>>>>>>>>>> That's OK, but why did you remove the Xen unstable test?
>>>>>>>>>
>>>>>>>>> >From Xen 4.9 on pkg-config will return the needed information.
>>>> There is
>>>>>>>>> no longer a need for a test program to determine the Xen version.
>>>> After
>>>>>>>>> all this was the main objective of my series adding the pkg-config
>>>>>>>>> files to Xen.
>>>>>>>>
>>>>>>>> I was going to say something like "yeah, but is pkg-config always
>>>>>>>> available?" In reality, QEMU already has pkg-config as build
>>>>>>>> dependency, so I guess there is no problem with that.
>>>>>>>>
>>>>>>>> Please add a note about this to the commit message.
>>>>>>>>
>>>>>>>
>>>>>>> Okay.
>>>>>>
>>>>>> Sorry to point this out only now, and I realize that it might be
>>>>>> unimportant for production builds, but it is important to me, and
>>>>>> developers in general, to be able to test a single QEMU tree against a
>>>>>> number of Xen trees (all releases from 4.3 onward).
>>>>>>
>>>>>> With this change (specifically dropping the 4.9 build test), out of tree
>>>>>> builds don't work anymore. I would like to be able to do:
>>>>>>
>>>>>> ./configure --enable-xen --target-list=i386-softmmu \
>>>>>>                 --extra-cflags="-I$DIR/tools/include \
>>>>>>                 -I$DIR/tools/libs/toollog/include \
>>>>>>                 -I$DIR/tools/libs/evtchn/include \
>>>>>>                 -I$DIR/tools/libs/gnttab/include \
>>>>>>                 -I$DIR/tools/libs/foreignmemory/include \
>>>>>>                 -I$DIR/tools/libs/devicemodel/include \
>>>>>>                 -I$DIR/tools/libxc/include \
>>>>>>                 -I$DIR/tools/xenstore/include \
>>>>>>                 -I$DIR/tools/xenstore/compat/include" \
>>>>>>                 --extra-ldflags="-L$DIR/tools/libxc \
>>>>>>                 -L$DIR/tools/xenstore \
>>>>>>                 -L$DIR/tools/libs/evtchn \
>>>>>>                 -L$DIR/tools/libs/gnttab \
>>>>>>                 -L$DIR/tools/libs/foreignmemory \
>>>>>>                 -L$DIR/tools/libs/devicemodel \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/toollog \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/evtchn \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/gnttab \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/call \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/foreignmemory \
>>>>>>                 -Wl,-rpath-link=$DIR/tools/libs/devicemodel" \
>>>>>>             --disable-kvm
>>>>>> make
>>>>>>
>>>>>> And the make should succeed. Is there a way to do that with pkg-
>> config?
>>>>>
>>>>> Sure, for Xen 4.9 just do:
>>>>>
>>>>> PKG_CONFIG_PATH=$(DIR)/tools/pkg-config ./configure \
>>>>> 		--enable-xen --target-list=i386-softmmu \
>>>>> 		--disable-kvm
>>>>> make
>>>>
>>>> Yes, that works, thanks! I committed it to my next branch adding
>>>> "pkg-config, which is already a build dependency of QEMU, will be used
>>>> exclusively to determine the Xen version from Xen 4.9 onward." to the
>>>> commit message.
>>>
>>> A further question...
>>>
>>> I have a xen tree which I've been using to build and install master against
>> my own checked out QEMU repo. No problem with that. I've now reverted
>> my tree to 4.7.0 and cannot build tools (even after a make distclean) because
>> QEMU's configure is still getting up a xen_ctrl_version of 40900. This is
>> because pkg-config is still finding a 4.9.0 xencontrol package? Where is it
>> getting this from?
>>
>> Hmm, could it be you have Xen unstable installed on your machine?
> 
> I do indeed. I build on my test machine.
> 
>>
>> Didn't think of this problem. I can think of 3 solutions:
>>
>> a) delete the xencontrol.pc file (on my system under
>>    /usr/share/pkgconfig/ )
>>
> 
> I just found mine using pkg-config --debug... /usr/local/share/pkgconfig for me
> 
>> b) we add a patch to qemu to test an environment variable whether
>>    pkg-config should be ignored for Xen version detection
>>
>> c) set the environment variable PKG_CONFIG_LIBDIR to a local directory
>>    and copy all but the xen*.pc files from /usr/share/pkgconfig/ (or
>>    your correct directory) to it (or link them to avoid missing updates)
>>
>> OTOH this is something you have to be aware of for other packages as
>> well: mixing the build environment and the target environment can lead
>> to bad results. Now Xen has been added to the list.
>>
> 
> That's a change in behaviour that I, and probably others, have long been used to. What we really want, presumably, is to have pkg-config just look under tools/pkgconfig when querying for the version of xencontrol. Could that not be done by simply setting PKG_CONFIG_LIBDIR in QEMU's configure script, or would it still mean picking up installed libraries before ones just built?

I guess this would break qemu's configure badly as it wouldn't find all
the other library informations it is looking for via pkg-config.


Juergen
