Received: from eggs.gnu.org ([2001:4830:134:3::10]:43122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cikFW-0002GN-PP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cikFV-0006Sn-U9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:03:38 -0500
Date: Tue, 28 Feb 2017 17:03:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228160328.GG4090@noname.redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-5-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488194450-28056-5-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/24] qapi: qobject input visitor variant
 for use with keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
> From: "Daniel P. Berrange" <berrange@redhat.com>
> 
> Currently the QObjectInputVisitor assumes that all scalar values are
> directly represented as the final types declared by the thing being
> visited. i.e. it assumes an 'int' is using QInt, and a 'bool' is using
> QBool, etc.  This is good when QObjectInputVisitor is fed a QObject
> that came from a JSON document on the QMP monitor, as it will strictly
> validate correctness.
> 
> To allow QObjectInputVisitor to be reused for visiting a QObject
> originating from keyval_parse(), an alternative mode is needed where
> all the scalars types are represented as QString and converted on the
> fly to the final desired type.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Message-Id: <1475246744-29302-8-git-send-email-berrange@redhat.com>
> 
> Rebased, conflicts resolved, commit message updated to refer to
> keyval_parse().  autocast replaced by keyval in identifiers,
> noautocast replaced by fail in tests.
> 
> Fix qobject_input_type_uint64_keyval() not to reject '-', for QemuOpts
> compatibility: replace parse_uint_full() by open-coded
> parse_option_number().  The next commit will add suitable tests.
> Leave out the fancy ERANGE error reporting for now, but add a TODO
> comment.  Add it qobject_input_type_int64_keyval() and
> qobject_input_type_number_keyval(), too.
> 
> Open code parse_option_bool() and parse_option_size() so we have to
> call qobject_input_get_name() only when actually needed.  Again, leave
> out ERANGE error reporting for now.
> 
> QAPI/QMP downstream extension prefixes __RFQDN_ don't work, because
> keyval_parse() splits them at '.'.  Add a TODO comment there.
> 
> qobject_input_type_int64_keyval(), qobject_input_type_uint64_keyval(),
> qobject_input_type_number_keyval() tweaked for style.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
