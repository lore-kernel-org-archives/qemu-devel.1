Received: from eggs.gnu.org ([209.51.188.92]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gzhUW-0006CL-Ht
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gzhUU-0001TU-F5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:42:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190301123608.GB5861@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<61bbfa3721938326edb03db58a6a246b384f3260.1547739122.git.berto@igalia.com>
	<20190212180231.GJ5283@localhost.localdomain>
	<w51zhqe7q01.fsf@maestria.local.igalia.com>
	<20190301123608.GB5861@localhost.localdomain>
Date: Fri, 01 Mar 2019 13:42:05 +0100
Message-ID: <w51woli7oma.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/13] block: Add 'runtime_opts' and
 'mutable_opts' fields to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 01 Mar 2019 01:36:08 PM CET, Kevin Wolf wrote:
> Am 01.03.2019 um 13:12 hat Alberto Garcia geschrieben:
>> On Tue 12 Feb 2019 07:02:31 PM CET, Kevin Wolf wrote:
>> >> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> >> index fd0e88d17a..e680dda86b 100644
>> >> --- a/include/block/block_int.h
>> >> +++ b/include/block/block_int.h
>> >> @@ -345,6 +345,13 @@ struct BlockDriver {
>> >>  
>> >>      /* List of options for creating images, terminated by name == NULL */
>> >>      QemuOptsList *create_opts;
>> >> +    /* Runtime options for a block device, terminated by name == NULL */
>> >> +    QemuOptsList *runtime_opts;
>> >
>> > I'm not sure if using a QemuOptsList here is a good idea. Currently,
>> > we use QemuOptsLists for most options, but there are some drivers that
>> > use it only for part of their options, or not at all, using direct
>> > QDict accesses or QAPI objects for the rest.
>> 
>> My intention was to avoid having two separate lists with the runtime
>> options of a driver. For this feature we really need that list to
>> contain all options, otherwise there's no way to know whether a missing
>> option is really missing or if it doesn't exist in the first place.
>
> Yes, I understand your intention and the requirement. My point is just
> that the existing QemuOptsLists are often _not_ complete, so they
> can't fulfill the requirement.

Perhaps a new data structure with a list of runtime options and whether
they can be resetted to their default value or not.

Berto
