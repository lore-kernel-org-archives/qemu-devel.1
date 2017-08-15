Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhe46-0001Vn-A4
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1dhe45-0001Da-Ef
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:34 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1dhe45-0001DC-7C
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:47:33 -0400
Received: by mail-wr0-x232.google.com with SMTP id x43so4393335wrb.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:47:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bbad51b9-55b6-44c8-87ca-b3fd052d8805@redhat.com>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
	<bbad51b9-55b6-44c8-87ca-b3fd052d8805@redhat.com>
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Tue, 15 Aug 2017 17:47:11 +0200
Message-ID: <CAPHE7Nq6J+17Wt0_GErJ_5fVSowYXMWoAwwUtEDR00jv5mdt9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 3/3] hmp: introduce 'info
 memory-size-summary' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Hi Eric,

Thank you for the input. I will update it with the next version. Btw, most
of HMP "info *" commands use '-' instead of '_' in names =)

Best regards,
Vadim

On Fri, Jul 28, 2017 at 8:27 PM, Eric Blake <eblake@redhat.com> wrote:

> On 07/28/2017 07:10 AM, Vadim Galitsyn wrote:
> > This command is an equivalent of QMP command query-memory-size-summary.
> > It provides the following memory information in bytes:
> >
> >   * base-memory - size of "base" memory specified with command line
> option -m.
> >
> >   * hotunpluggable-memory - amount of memory that was hot-plugged.
> >     If target does not have CONFIG_MEM_HOTPLUG enabled, no
> >     value is reported.
>
> Most of our HMP commands use underscores between words; for consistency,
> you might want to name it 'info memory_size_summary'.  Also, between the
> new QMP and HMP parameters, do you have any testsuite coverage?  I know
> we don't have many existing QMP tests to copy from, but where possible,
> we want to avoid adding new QMP features that don't have some sort of
> coverage.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
