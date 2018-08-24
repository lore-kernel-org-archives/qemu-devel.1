Received: from eggs.gnu.org ([2001:4830:134:3::10]:39700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ft5c7-00042r-Df
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 02:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ft5c3-0003b5-Ql
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 02:30:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419132026.5494-1-kraxel@redhat.com>
	<20180419132026.5494-2-kraxel@redhat.com>
	<87va92dv39.fsf@dusky.pond.sub.org>
Date: Fri, 24 Aug 2018 08:30:23 +0200
In-Reply-To: <87va92dv39.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 26 Jul 2018 14:45:14 +0200")
Message-ID: <87tvnk6zuo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: add qapi parser for -display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> Add parse_display_qapi() function which parses the -display command line
>> using a qapi visitor for DisplayOptions.  Wire up as default catch in
>> parse_display().
>>
>> Improves the error message for unknown display types.
>>
>> Also enables json as -display argument, i.e. -display "{ 'type': 'gtk' }"
>
> This new option argument syntax is undocumented.  Intentional?

Please advise.
