Received: from eggs.gnu.org ([2001:4830:134:3::10]:35726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBh8T-0001n0-Hb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBh8Q-0003Sk-84
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBh8P-0003SR-VS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:08:14 -0500
Date: Mon, 6 Nov 2017 21:08:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171106130800.GA4764@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<150996313592.327.4353631543325177108@bafd83ae6430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150996313592.327.4353631543325177108@bafd83ae6430>
Subject: Re: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@redhat.com, shajnocz@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com, dgilbert@redhat.com

On Mon, Nov 06, 2017 at 02:12:17AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution support
> Type: series
> Message-id: 20171106094643.14881-1-peterx@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20171106094643.14881-1-peterx@redhat.com -> patchew/20171106094643.14881-1-peterx@redhat.com
> Switched to a new branch 'test'
> 5525c4e791 tests: qmp-test: add oob test
> ccc9e4c399 tests: qmp-test: verify command batching
> 7f45b4c6c0 docs: update QMP documents for OOB commands
> 58cfe877d2 monitor: enable IO thread for (qmp & !mux) typed
> 5e1d56ce74 qmp: isolate responses into io thread
> aef4275536 qmp: let migrate-incoming allow out-of-band
> 5e68beacf3 qmp: support out-of-band (oob) execution
> 43c7215a30 qapi: introduce new cmd option "allow-oob"
> e11127ba4b monitor: send event when request queue full
> 45cef4f7e4 qmp: add new event "request-dropped"
> 485da28be1 monitor: separate QMP parser and dispatcher
> 4892fe9ca2 monitor: let monitor_{suspend|resume} thread safe
> 1b86166d9c monitor: introduce monitor_qmp_respond()
> 0f48093add qmp: introduce some capability helpers
> 8d3f33043d qmp: negociate QMP capabilities
> 023b386d0e qmp: introduce QMPCapability
> 2bde5ca8ce monitor: allow to use IO thread for parsing
> f4cc112f80 monitor: create monitor dedicate iothread
> 3590fdc1d4 monitor: let mon_list be tail queue
> 11c818a9ac monitor: unify global init
> 36d3efb87d monitor: move the cur_mon hack deeper for QMP
> bf3e493a86 qjson: add "opaque" field to JSONMessageParser
> 17367fe7a1 monitor: move skip_flush into monitor_data_init
> 0c98d4baa4 qobject: let object_property_get_str() use new API
> aa4b973dd5 qobject: introduce qobject_get_try_str()
> 981ccebc1e qobject: introduce qstring_get_try_str()
> d40ba38085 char-io: fix possible race on IOWatchPoll
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/27: char-io: fix possible race on IOWatchPoll...
> Checking PATCH 2/27: qobject: introduce qstring_get_try_str()...
> Checking PATCH 3/27: qobject: introduce qobject_get_try_str()...
> Checking PATCH 4/27: qobject: let object_property_get_str() use new API...
> Checking PATCH 5/27: monitor: move skip_flush into monitor_data_init...
> Checking PATCH 6/27: qjson: add "opaque" field to JSONMessageParser...
> Checking PATCH 7/27: monitor: move the cur_mon hack deeper for QMP...
> Checking PATCH 8/27: monitor: unify global init...
> Checking PATCH 9/27: monitor: let mon_list be tail queue...
> Checking PATCH 10/27: monitor: create monitor dedicate iothread...
> Checking PATCH 11/27: monitor: allow to use IO thread for parsing...
> Checking PATCH 12/27: qmp: introduce QMPCapability...
> Checking PATCH 13/27: qmp: negociate QMP capabilities...
> Checking PATCH 14/27: qmp: introduce some capability helpers...
> Checking PATCH 15/27: monitor: introduce monitor_qmp_respond()...
> Checking PATCH 16/27: monitor: let monitor_{suspend|resume} thread safe...
> ERROR: braces {} are necessary for all arms of this statement
> #28: FILE: monitor.c:4014:
> +    if (atomic_dec_fetch(&mon->suspend_cnt) == 0)
> [...]
> 
> ERROR: Missing Signed-off-by: line(s)

Will add it in next post.  I still haven't found a good way to let
magit add this line for me every time automatically.

Please review the rest of things, thanks.

-- 
Peter Xu
