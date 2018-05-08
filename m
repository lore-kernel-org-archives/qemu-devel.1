Received: from eggs.gnu.org ([2001:4830:134:3::10]:49464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fFqli-0000BA-0L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fFqle-0004XC-2O
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:46:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fFqld-0004WN-Qp
	for qemu-devel@nongnu.org; Mon, 07 May 2018 20:46:09 -0400
Date: Tue, 8 May 2018 08:45:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180508004559.GE22503@lemon.usersys.redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
	<152542019271.2502.11957748187759069388@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152542019271.2502.11957748187759069388@71c20359a636>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] slirp: Add query-usernet QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, jasowang@redhat.com, f4bug@amsat.org, armbru@redhat.com, jan.kiszka@siemens.com, alex.bennee@linaro.org

On Fri, 05/04 00:49, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:

Code indentation issues are due to the pre-existing style in the file and is
not changed by the patch.

Fam

> 
> Type: series
> Message-id: 20180504074207.22634-1-famz@redhat.com
> Subject: [Qemu-devel] [PATCH v6 0/4] slirp: Add query-usernet QMP command
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
> git config --local diff.algorithm histogram
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
>  * [new tag]               patchew/20180504074207.22634-1-famz@redhat.com -> patchew/20180504074207.22634-1-famz@redhat.com
> Switched to a new branch 'test'
> c08e6e3a7f tests: Use query-usernet instead of 'info usernet'
> c493a69267 slirp: Add "query-usernet" QMP command
> 5150e445b4 slirp: Use QAPI enum to replace TCPS_* macros
> 0f3b1a240b qapi: Introduce UsernetTcpState
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: qapi: Introduce UsernetTcpState...
> Checking PATCH 2/4: slirp: Use QAPI enum to replace TCPS_* macros...
> ERROR: code indent should never use tabs
> #112: FILE: slirp/tcp_input.c:88:
> +^I    (tp)->t_state == USERNET_TCP_STATE_ESTABLISHED) { \$
> 
> ERROR: code indent should never use tabs
> #121: FILE: slirp/tcp_input.c:193:
> +^Iif (tp->t_state == USERNET_TCP_STATE_SYN_RECEIVED && ti->ti_len)$
> 
> ERROR: code indent should never use tabs
> #130: FILE: slirp/tcp_input.c:460:
> +^I  tp->t_state = USERNET_TCP_STATE_LISTEN;$
> 
> ERROR: code indent should never use tabs
> #139: FILE: slirp/tcp_input.c:476:
> +^Iif (tp->t_state == USERNET_TCP_STATE_CLOSED)$
> 
> ERROR: braces {} are necessary for all arms of this statement
> #139: FILE: slirp/tcp_input.c:476:
> +	if (tp->t_state == USERNET_TCP_STATE_CLOSED)
> [...]
> 
> ERROR: code indent should never use tabs
> #148: FILE: slirp/tcp_input.c:495:
> +^Iif (optp && tp->t_state != USERNET_TCP_STATE_LISTEN)$
> 
> ERROR: braces {} are necessary for all arms of this statement
> #148: FILE: slirp/tcp_input.c:495:
> +	if (optp && tp->t_state != USERNET_TCP_STATE_LISTEN)
> [...]
> 
> ERROR: code indent should never use tabs
> #157: FILE: slirp/tcp_input.c:516:
> +^Iif (tp->t_state == USERNET_TCP_STATE_ESTABLISHED &&$
> 
> ERROR: code indent should never use tabs
> #166: FILE: slirp/tcp_input.c:618:
> +^Icase USERNET_TCP_STATE_LISTEN: {$
> 
> ERROR: code indent should never use tabs
> #175: FILE: slirp/tcp_input.c:729:
> +^I    tp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;$
> 
> ERROR: code indent should never use tabs
> #184: FILE: slirp/tcp_input.c:763:
> +^I  tp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;$
> 
> ERROR: code indent should never use tabs
> #188: FILE: slirp/tcp_input.c:766:
> +^I} /* case USERNET_TCP_STATE_LISTEN */$
> 
> ERROR: code indent should never use tabs
> #197: FILE: slirp/tcp_input.c:780:
> +^Icase USERNET_TCP_STATE_SYN_SENT:$
> 
> ERROR: code indent should never use tabs
> #206: FILE: slirp/tcp_input.c:807:
> +^I^I^Itp->t_state = USERNET_TCP_STATE_ESTABLISHED;$
> 
> ERROR: code indent should never use tabs
> #215: FILE: slirp/tcp_input.c:818:
> +^I^I^Itp->t_state = USERNET_TCP_STATE_SYN_RECEIVED;$
> 
> ERROR: code indent should never use tabs
> #224: FILE: slirp/tcp_input.c:888:
> +^I    tp->t_state > USERNET_TCP_STATE_CLOSE_WAIT && ti->ti_len) {$
> 
> ERROR: code indent should never use tabs
> #233: FILE: slirp/tcp_input.c:907:
> +^I^I^I    tp->t_state == USERNET_TCP_STATE_TIME_WAIT &&$
> 
> ERROR: code indent should never use tabs
> #247: FILE: slirp/tcp_input.c:943:
> +^Icase USERNET_TCP_STATE_SYN_RECEIVED:$
> 
> ERROR: code indent should never use tabs
> #248: FILE: slirp/tcp_input.c:944:
> +^Icase USERNET_TCP_STATE_ESTABLISHED:$
> 
> ERROR: code indent should never use tabs
> #249: FILE: slirp/tcp_input.c:945:
> +^Icase USERNET_TCP_STATE_FIN_WAIT_1:$
> 
> ERROR: code indent should never use tabs
> #250: FILE: slirp/tcp_input.c:946:
> +^Icase USERNET_TCP_STATE_FIN_WAIT_2:$
> 
> ERROR: code indent should never use tabs
> #251: FILE: slirp/tcp_input.c:947:
> +^Icase USERNET_TCP_STATE_CLOSE_WAIT:$
> 
> ERROR: code indent should never use tabs
> #252: FILE: slirp/tcp_input.c:948:
> +^I^Itp->t_state = USERNET_TCP_STATE_CLOSED;$
> 
> ERROR: code indent should never use tabs
> #259: FILE: slirp/tcp_input.c:952:
> +^Icase USERNET_TCP_STATE_CLOSING:$
> 
> ERROR: code indent should never use tabs
> #260: FILE: slirp/tcp_input.c:953:
> +^Icase USERNET_TCP_STATE_LAST_ACK:$
> 
> ERROR: code indent should never use tabs
> #261: FILE: slirp/tcp_input.c:954:
> +^Icase USERNET_TCP_STATE_TIME_WAIT:$
> 
> ERROR: code indent should never use tabs
> #270: FILE: slirp/tcp_input.c:982:
> +^Icase USERNET_TCP_STATE_SYN_RECEIVED:$
> 
> ERROR: code indent should never use tabs
> #276: FILE: slirp/tcp_input.c:987:
> +^I^Itp->t_state = USERNET_TCP_STATE_ESTABLISHED;$
> 
> ERROR: code indent should never use tabs
> #285: FILE: slirp/tcp_input.c:1007:
> +^I^I    tp->t_state = USERNET_TCP_STATE_FIN_WAIT_1;$
> 
> ERROR: code indent should never use tabs
> #300: FILE: slirp/tcp_input.c:1027:
> +^Icase USERNET_TCP_STATE_ESTABLISHED:$
> 
> ERROR: code indent should never use tabs
> #301: FILE: slirp/tcp_input.c:1028:
> +^Icase USERNET_TCP_STATE_FIN_WAIT_1:$
> 
> ERROR: code indent should never use tabs
> #302: FILE: slirp/tcp_input.c:1029:
> +^Icase USERNET_TCP_STATE_FIN_WAIT_2:$
> 
> ERROR: code indent should never use tabs
> #303: FILE: slirp/tcp_input.c:1030:
> +^Icase USERNET_TCP_STATE_CLOSE_WAIT:$
> 
> ERROR: code indent should never use tabs
> #304: FILE: slirp/tcp_input.c:1031:
> +^Icase USERNET_TCP_STATE_CLOSING:$
> 
> ERROR: code indent should never use tabs
> #305: FILE: slirp/tcp_input.c:1032:
> +^Icase USERNET_TCP_STATE_LAST_ACK:$
> 
> ERROR: code indent should never use tabs
> #306: FILE: slirp/tcp_input.c:1033:
> +^Icase USERNET_TCP_STATE_TIME_WAIT:$
> 
> ERROR: code indent should never use tabs
> #315: FILE: slirp/tcp_input.c:1164:
> +^I^Icase USERNET_TCP_STATE_FIN_WAIT_1:$
> 
> ERROR: code indent should never use tabs
> #324: FILE: slirp/tcp_input.c:1176:
> +^I^I^I^Itp->t_state = USERNET_TCP_STATE_FIN_WAIT_2;$
> 
> ERROR: code indent should never use tabs
> #333: FILE: slirp/tcp_input.c:1186:
> +^I^Icase USERNET_TCP_STATE_CLOSING:$
> 
> ERROR: code indent should never use tabs
> #336: FILE: slirp/tcp_input.c:1188:
> +^I^I^I^Itp->t_state = USERNET_TCP_STATE_TIME_WAIT;$
> 
> ERROR: code indent should never use tabs
> #345: FILE: slirp/tcp_input.c:1200:
> +^I^Icase USERNET_TCP_STATE_LAST_ACK:$
> 
> ERROR: code indent should never use tabs
> #354: FILE: slirp/tcp_input.c:1212:
> +^I^Icase USERNET_TCP_STATE_TIME_WAIT:$
> 
> WARNING: line over 80 characters
> #363: FILE: slirp/tcp_input.c:1320:
> +			 * will got to USERNET_TCP_STATE_LAST_ACK, and use tcp_output()
> 
> ERROR: code indent should never use tabs
> #363: FILE: slirp/tcp_input.c:1320:
> +^I^I^I * will got to USERNET_TCP_STATE_LAST_ACK, and use tcp_output()$
> 
> ERROR: code indent should never use tabs
> #373: FILE: slirp/tcp_input.c:1334:
> +^I^Icase USERNET_TCP_STATE_SYN_RECEIVED:$
> 
> ERROR: code indent should never use tabs
> #374: FILE: slirp/tcp_input.c:1335:
> +^I^Icase USERNET_TCP_STATE_ESTABLISHED:$
> 
> ERROR: code indent should never use tabs
> #377: FILE: slirp/tcp_input.c:1337:
> +^I^I    tp->t_state = USERNET_TCP_STATE_LAST_ACK;$
> 
> ERROR: code indent should never use tabs
> #380: FILE: slirp/tcp_input.c:1339:
> +^I^I    tp->t_state = USERNET_TCP_STATE_CLOSE_WAIT;$
> 
> ERROR: code indent should never use tabs
> #389: FILE: slirp/tcp_input.c:1346:
> +^I^Icase USERNET_TCP_STATE_FIN_WAIT_1:$
> 
> ERROR: code indent should never use tabs
> #390: FILE: slirp/tcp_input.c:1347:
> +^I^I^Itp->t_state = USERNET_TCP_STATE_CLOSING;$
> 
> ERROR: code indent should never use tabs
> #400: FILE: slirp/tcp_input.c:1355:
> +^I^Icase USERNET_TCP_STATE_FIN_WAIT_2:$
> 
> ERROR: code indent should never use tabs
> #401: FILE: slirp/tcp_input.c:1356:
> +^I^I^Itp->t_state = USERNET_TCP_STATE_TIME_WAIT;$
> 
> ERROR: code indent should never use tabs
> #410: FILE: slirp/tcp_input.c:1364:
> +^I^Icase USERNET_TCP_STATE_TIME_WAIT:$
> 
> ERROR: code indent should never use tabs
> #431: FILE: slirp/tcp_subr.c:286:
> +^Itp->t_state = USERNET_TCP_STATE_CLOSED;$
> 
> ERROR: code indent should never use tabs
> #440: FILE: slirp/tcp_subr.c:305:
> +^I^Itp->t_state = USERNET_TCP_STATE_CLOSED;$
> 
> ERROR: code indent should never use tabs
> #452: FILE: slirp/tcp_subr.c:375:
> +^Icase USERNET_TCP_STATE_CLOSED:$
> 
> ERROR: code indent should never use tabs
> #453: FILE: slirp/tcp_subr.c:376:
> +^Icase USERNET_TCP_STATE_LISTEN:$
> 
> ERROR: code indent should never use tabs
> #454: FILE: slirp/tcp_subr.c:377:
> +^Icase USERNET_TCP_STATE_SYN_SENT:$
> 
> ERROR: code indent should never use tabs
> #455: FILE: slirp/tcp_subr.c:378:
> +^I^Itp->t_state = USERNET_TCP_STATE_CLOSED;$
> 
> ERROR: code indent should never use tabs
> #462: FILE: slirp/tcp_subr.c:382:
> +^Icase USERNET_TCP_STATE_SYN_RECEIVED:$
> 
> ERROR: code indent should never use tabs
> #463: FILE: slirp/tcp_subr.c:383:
> +^Icase USERNET_TCP_STATE_ESTABLISHED:$
> 
> ERROR: code indent should never use tabs
> #464: FILE: slirp/tcp_subr.c:384:
> +^I^Itp->t_state = USERNET_TCP_STATE_FIN_WAIT_1;$
> 
> ERROR: code indent should never use tabs
> #469: FILE: slirp/tcp_subr.c:387:
> +^Icase USERNET_TCP_STATE_CLOSE_WAIT:$
> 
> ERROR: code indent should never use tabs
> #470: FILE: slirp/tcp_subr.c:388:
> +^I^Itp->t_state = USERNET_TCP_STATE_LAST_ACK;$
> 
> ERROR: code indent should never use tabs
> #500: FILE: slirp/tcp_timer.c:139:
> +^I^Iif (tp->t_state != USERNET_TCP_STATE_TIME_WAIT &&$
> 
> ERROR: code indent should never use tabs
> #509: FILE: slirp/tcp_timer.c:263:
> +^I^Iif (tp->t_state < USERNET_TCP_STATE_ESTABLISHED)$
> 
> WARNING: line over 80 characters
> #513: FILE: slirp/tcp_timer.c:266:
> +		if ((SO_OPTIONS) && tp->t_state <= USERNET_TCP_STATE_CLOSE_WAIT) {
> 
> ERROR: code indent should never use tabs
> #513: FILE: slirp/tcp_timer.c:266:
> +^I^Iif ((SO_OPTIONS) && tp->t_state <= USERNET_TCP_STATE_CLOSE_WAIT) {$
> 
> total: 66 errors, 2 warnings, 444 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/4: slirp: Add "query-usernet" QMP command...
> Checking PATCH 4/4: tests: Use query-usernet instead of 'info usernet'...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
