Return-Path: <SRS0=P1lm=VZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA349C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 23:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835942075B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2019 23:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835942075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrsjI-000889-MA
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 19:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hrsir-0007gt-Rv
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hrsip-0008LD-VI
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 19:37:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hrsim-0008JS-3Q; Sun, 28 Jul 2019 19:36:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F41C64E919;
 Sun, 28 Jul 2019 23:36:53 +0000 (UTC)
Received: from localhost (ovpn-116-18.gru2.redhat.com [10.97.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 018B060BFB;
 Sun, 28 Jul 2019 23:36:50 +0000 (UTC)
Date: Sun, 28 Jul 2019 20:36:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190728233648.GA4313@habkost.net>
References: <20190726225201.10561-1-jsnow@redhat.com>
 <20190726225201.10561-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726225201.10561-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Sun, 28 Jul 2019 23:36:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: use python logging for
 iotests.log()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 06:52:01PM -0400, John Snow wrote:
> We can turn logging on/off globally instead of per-function.
> 
> Remove use_log from run_job, and use python logging to turn on
> diffable output when we run through a script entry point.
> 
> (No, I have no idea why output on 245 changed. I really don't.)

I believe this happens because the logging StreamHandler will
flush the stream at every call.

I see the same output reordering on 245 if I add a
sys.stdout.flush() call to iotests.log(), or if I change
iotests.main() to use sys.stdout for the unittest runner output.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/030        |  4 +--
>  tests/qemu-iotests/245        |  1 +
>  tests/qemu-iotests/245.out    | 24 +++++++++---------
>  tests/qemu-iotests/iotests.py | 48 ++++++++++++++++++++---------------
>  4 files changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 1b69f318c6..a382cb430b 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -411,8 +411,8 @@ class TestParallelOps(iotests.QMPTestCase):
>          result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
>          self.assert_qmp(result, 'return', {})
>  
> -        self.vm.run_job(job='drive0', auto_dismiss=True, use_log=False)
> -        self.vm.run_job(job='node4', auto_dismiss=True, use_log=False)
> +        self.vm.run_job(job='drive0', auto_dismiss=True)
> +        self.vm.run_job(job='node4', auto_dismiss=True)

So, this one is the only run_job() caller specifying
use_log=False.  It doesn't call activate_logging() anywhere, so
it seems OK.

However, we need to ensure all the other run_job() callers will
actually enable logging.  The remaining run_job() callers are:
206 207 210 211 212 213 237 245 255 256.

These look OK:
206:iotests.script_initialize(supported_fmts=['qcow2'])
245:    iotests.activate_logging()
255:iotests.script_initialize(supported_fmts=['qcow2'])
256:iotests.script_initialize(supported_fmts=['qcow2'])
257:    iotests.script_main(main, supported_fmts=['qcow2'])

These don't seem to call activate_logging() anywhere:
207 210 211 212 213 237.

What about other scripts calling log() that aren't calling activate_logging()?
Let's see:

  $ git grep -LE 'script_main|script_initialize|activate_logging' \
       $(grep -lP '(?<!get_)log\(' [0-9]*)
  207
  210
  211
  212
  213
  237
  $ 


I didn't run all of these test cases, but I can see that 210 is
now failing:

  $ ./check -luks 210
  QEMU          -- "/home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
  QEMU_IMG      -- "/home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/../../qemu-img"
  QEMU_IO       -- "/home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/../../qemu-io"  --cache writeback
  QEMU_NBD      -- "/home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/../../qemu-nbd"
  IMGFMT        -- luks (iter-time=10)
  IMGPROTO      -- file

  TEST_DIR      -- /home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER -- /home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/socket_scm_helper
  
  210      fail       [20:20:37] [20:21:00]      (last: 22s)   output mismatch (see 210.out.bad)
  --- /home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/210.out 2019-07-28 18:38:18.040555415 -0300
  +++ /home/ehabkost/rh/proj/virt/qemu/tests/qemu-iotests/210.out.bad     2019-07-28 20:20:37.398971280 -0300
  @@ -1,231 +0,0 @@
  -=== Successful image creation (defaults) ===
  -
  -{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.luks", "size": 0}}}
  [...]


As most test cases require logging to be enabled, my suggestion
is to activate logging by default and provide a
disable_test_logging() function that can be used by 030.


>          self.assert_no_active_block_jobs()
>  
>      # Test a block-stream and a block-commit job in parallel
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index bc1ceb9792..3bc29acb33 100644
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -1000,4 +1000,5 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>          self.reopen(opts, {'backing': 'hd2'})
>  
>  if __name__ == '__main__':
> +    iotests.activate_logging()
>      iotests.main(supported_fmts=["qcow2"])
> diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
> index a19de5214d..15c3630e92 100644
> --- a/tests/qemu-iotests/245.out
> +++ b/tests/qemu-iotests/245.out
> @@ -1,17 +1,17 @@
> +{"execute": "job-finalize", "arguments": {"id": "commit0"}}
> +{"return": {}}
> +{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> +{"return": {}}
> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> +{"return": {}}
> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  ..................
>  ----------------------------------------------------------------------
>  Ran 18 tests
>  
>  OK
> -{"execute": "job-finalize", "arguments": {"id": "commit0"}}
> -{"return": {}}
> -{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> -{"return": {}}
> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
> -{"return": {}}
> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 5e9b2989dd..d55ca864eb 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -35,6 +35,13 @@ from collections import OrderedDict
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>  from qemu import qtest
>  
> +# Use this logger for logging messages directly from the iotests module
> +logger = logging.getLogger(__name__)
> +logger.addHandler(logging.NullHandler())
> +
> +# Use this logger for messages that ought to be used for diff output.
> +test_logger = logging.getLogger('.'.join((__name__, 'iotest')))
> +test_logger.addHandler(logging.NullHandler())
>  
>  # This will not work if arguments contain spaces but is necessary if we
>  # want to support the override options that ./check supports.
> @@ -343,10 +350,10 @@ def log(msg, filters=[], indent=None):
>          separators = (', ', ': ') if indent is None else (',', ': ')
>          # Don't sort if it's already sorted
>          do_sort = not isinstance(msg, OrderedDict)
> -        print(json.dumps(msg, sort_keys=do_sort,
> -                         indent=indent, separators=separators))
> +        test_logger.info(json.dumps(msg, sort_keys=do_sort,
> +                                    indent=indent, separators=separators))
>      else:
> -        print(msg)
> +        test_logger.info(msg)
>  
>  class Timeout:
>      def __init__(self, seconds, errmsg = "Timeout"):
> @@ -559,7 +566,7 @@ class VM(qtest.QEMUQtestMachine):
>  
>      # Returns None on success, and an error string on failure
>      def run_job(self, job, auto_finalize=True, auto_dismiss=False,
> -                pre_finalize=None, cancel=False, use_log=True, wait=60.0):
> +                pre_finalize=None, cancel=False, wait=60.0):
>          """
>          run_job moves a job from creation through to dismissal.
>  
> @@ -572,7 +579,6 @@ class VM(qtest.QEMUQtestMachine):
>                               invoked prior to issuing job-finalize, if any.
>          :param cancel: Bool. When true, cancels the job after the pre_finalize
>                         callback.
> -        :param use_log: Bool. When false, does not log QMP messages.
>          :param wait: Float. Timeout value specifying how long to wait for any
>                       event, in seconds. Defaults to 60.0.
>          """
> @@ -590,8 +596,7 @@ class VM(qtest.QEMUQtestMachine):
>          while True:
>              ev = filter_qmp_event(self.events_wait(events))
>              if ev['event'] != 'JOB_STATUS_CHANGE':
> -                if use_log:
> -                    log(ev)
> +                log(ev)
>                  continue
>              status = ev['data']['status']
>              if status == 'aborting':
> @@ -599,24 +604,15 @@ class VM(qtest.QEMUQtestMachine):
>                  for j in result['return']:
>                      if j['id'] == job:
>                          error = j['error']
> -                        if use_log:
> -                            log('Job failed: %s' % (j['error']))
> +                        log('Job failed: %s' % (j['error']))
>              elif status == 'pending' and not auto_finalize:
>                  if pre_finalize:
>                      pre_finalize()
> -                if cancel and use_log:
> +                if cancel:
>                      self.qmp_log('job-cancel', id=job)
> -                elif cancel:
> -                    self.qmp('job-cancel', id=job)
> -                if use_log:
> -                    self.qmp_log('job-finalize', id=job)
> -                else:
> -                    self.qmp('job-finalize', id=job)
> +                self.qmp_log('job-finalize', id=job)
>              elif status == 'concluded' and not auto_dismiss:
> -                if use_log:
> -                    self.qmp_log('job-dismiss', id=job)
> -                else:
> -                    self.qmp('job-dismiss', id=job)
> +                self.qmp_log('job-dismiss', id=job)
>              elif status == 'null':
>                  return error
>  
> @@ -924,6 +920,7 @@ def execute_setup_common(supported_fmts=[], supported_oses=['linux'],
>              output = io.BytesIO()
>  
>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> +    logger.debug("iotests debugging messages active")
>      return output, verbosity, debug
>  
>  def execute_test(test_function=None, *args, **kwargs):
> @@ -935,14 +932,25 @@ def execute_test(test_function=None, *args, **kwargs):
>      else:
>          test_function()
>  
> +def activate_logging():
> +    """Activate iotests.log() output to stdout for script-style tests."""
> +    handler = logging.StreamHandler(stream=sys.stdout)
> +    formatter = logging.Formatter('%(message)s')
> +    handler.setFormatter(formatter)
> +    test_logger.addHandler(handler)
> +    test_logger.setLevel(logging.INFO)
> +    test_logger.propagate = False
> +
>  # This is called from script-style iotests without a single point of entry
>  def script_initialize(*args, **kwargs):
>      """Initialize script-style tests without running any tests."""
> +    activate_logging()
>      execute_setup_common(*args, **kwargs)
>  
>  # This is called from script-style iotests with a single point of entry
>  def script_main(test_function, *args, **kwargs):
>      """Run script-style tests outside of the unittest framework"""
> +    activate_logging()
>      execute_test(test_function, *args, **kwargs)
>  
>  # This is called from unittest style iotests
> -- 
> 2.21.0
> 

-- 
Eduardo

