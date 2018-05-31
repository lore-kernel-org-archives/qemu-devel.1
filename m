Received: from eggs.gnu.org ([2001:4830:134:3::10]:59942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOTBU-0005ST-JK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOTBT-000143-LN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:28 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOTBT-00013R-Bg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:27 -0400
Received: by mail-pl0-x243.google.com with SMTP id v24-v6so13804050plo.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 12:24:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531212249.34cd85d2@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<17b8b06c00e359d1cb71b883371ad8c677a0e477.1527310210.git.keno@alumni.harvard.edu>
	<20180529230951.27a41574@bahia.lan>
	<CABV8kRydQ1wiRm9T-wet64i3n7KpqA7pCJrbZMWFfVz1WRQupw@mail.gmail.com>
	<20180531212249.34cd85d2@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 15:23:45 -0400
Message-ID: <CABV8kRxdxBtsNdwLLL4BeNLck88L=SuaydSsStMgip6SbN2H5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/13] 9p: darwin: Address minor differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

Well, I do have the patch already to switch this and the other patterns,
so let me know if you want it or not ;).

On Thu, May 31, 2018 at 3:22 PM, Greg Kurz <groug@kaod.org> wrote:
> On Thu, 31 May 2018 12:27:35 -0400
> Keno Fischer <keno@juliacomputing.com> wrote:
>
>> >> --- a/hw/9pfs/9p-local.c
>> >> +++ b/hw/9pfs/9p-local.c
>> >> @@ -67,7 +67,10 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
>> >>          assert(*path != '/');
>> >>
>> >>          head = g_strdup(path);
>> >> -        c = strchrnul(path, '/');
>> >> +        /* equivalent to strchrnul(), but that is not available on Darwin */
>> >
>> > Please make a qemu_strchrnul() helper with a separate implementation for Darwin
>> > then. I guess you can put it in this file since there aren't any other users in
>> > the QEMU code base.
>>
>> There actually are, but they also use this pattern. Could you
>> suggest the best place to put this utility? I can submit a patch
>> to switch all instances of this pattern over.
>
> Oh if the pattern is already used in other places, it's probably not
> worth the pain... so please forget this :)
