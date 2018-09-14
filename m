Received: from eggs.gnu.org ([2001:4830:134:3::10]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g0nRH-000481-4m
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g0nRB-0000Tu-Hh
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:43:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g0nRA-0000Ol-P7
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 08:43:05 -0400
Received: by mail-it0-f67.google.com with SMTP id f14-v6so2321857ita.4
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 05:43:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180914105530.nxpfaqgegyktdpcp@sirius.home.kraxel.org>
References: <20180913112205.3252-1-marcandre.lureau@redhat.com>
	<20180914105530.nxpfaqgegyktdpcp@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 14 Sep 2018 16:43:00 +0400
Message-ID: <CAMxuvazESu9p4RpqYsBLfMqR5Vp0weP3jdSAmvPrMKpQzjQAzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, libvir-list <libvir-list@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

Hi

On Fri, Sep 14, 2018 at 2:55 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> +* --pidfile=PATH
>> +
>> +Write the process id (PID) to the given file PATH. This is mostly
>> +useful if the backend daemonize/fork itself.
>
> Is there any reason to daemonize itself?
>
> If not: shoud we disallow it and drop the --pidfile switch?
>
> If yes: should we add a --daemonize switch then to control whenever the
> process daemonizes itself?
>
> Otherwise the conventions look good to me.

Let's drop the daemonize/pidfile part from the initial spec. We can
later add it back if we have a good rationale.

thanks
